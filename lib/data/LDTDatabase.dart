import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Game.dart';
import 'package:living_dex_tracker/model/Livingdex.dart';

class LDTDatabase {
  static final LDTDatabase _lDTDatabase = new LDTDatabase._internal();

  final String pokemonTableName = "Pokemon";
  final String livingdexTableName = "Livingdex";
  final String capturedTableName = "Captured";
  final String gameTableName = "Game";
  final String pokemonGameTableName = "Pokemon_Game";

  Database db;

  bool didInit = false;

  static LDTDatabase get() {
    return _lDTDatabase;
  }

  LDTDatabase._internal();


  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }


  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "living_dex_tracker_database.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $pokemonTableName ("
                  "${Pokemon.db_id} INTEGER PRIMARY KEY,"
                  "${Pokemon.db_name} TEXT,"
                  "${Pokemon.db_national_number} INTEGER,"
                  "${Pokemon.db_sprite_url} TEXT,"
                  "${Pokemon.db_shiny_sprite_url} TEXT"
                  ")");
          await db.execute(
              "CREATE TABLE $gameTableName ("
                  "${Game.db_id} INTEGER PRIMARY KEY,"
                  "${Game.db_name} TEXT"
                  ")");
          await db.execute("CREATE TABLE $livingdexTableName ("
              "${Livingdex.db_id} INTEGER PRIMARY KEY,"
              "${Livingdex.db_name} TEXT,"
              "${Livingdex.db_shiny} INTEGER,"
              "${Livingdex.db_national} INTEGER,"
              "${Livingdex.db_gameId} INTEGER,"
              "FOREIGN KEY(${Livingdex.db_gameId}) REFERENCES $gameTableName(${Game.db_id})"
              ")");
          await db.execute("CREATE TABLE $capturedTableName ("
              "id INTEGER PRIMARY KEY, "
              "pokemon_id INTEGER,"
              "livingdex_id INTEGER,"
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(livingdex_id) REFERENCES $livingdexTableName(${Livingdex.db_id})"
              ")");
          await db.execute("CREATE TABLE $pokemonGameTableName ("
              "id INTEGER PRIMARY KEY, "
              "regional_id INTEGER,"
              "pokemon_id INTEGER,"
              "game_id INTEGER,"
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(game_id) REFERENCES $livingdexTableName(${Game.db_id})"
              ")");
        });
    didInit = true;
  }

  Future<Livingdex> getLivingdex(int id) async {
    var db = await _getDb();
    var result = await db.query(livingdexTableName,  where: 'id = ?', whereArgs: [id]);
    if (result.length > 0) return Livingdex.fromMap(result.first);
    return null;
  }

  Future<List<Livingdex>> listLivingdexes() async {
    var db = await _getDb();
    var result = await db.query(livingdexTableName);
    List<Livingdex> livingdexes = [];
    for(Map<String, dynamic> item in result) {
      livingdexes.add(Livingdex.fromMap(item));
    }
    return livingdexes;
  }

  Future<List<Game>> listGames() async {
    var db = await _getDb();
    var result = await db.query(gameTableName);
    List<Game> games = [];
    for(Map<String, dynamic> item in result) {
      games.add(Game.fromMap(item));
    }
    return games;
  }

  /* resultMapToList(List<Map<String, dynamic>> resultMap, objectFromMap){
    var objectList = [];
    for(Map<String, dynamic> item in resultMap) {
      objectList.add(objectFromMap(item));
    }
    return objectList;
  }
*/

  createLivingdex(Livingdex livingdex) async {
    var db = await _getDb();
    db.insert(livingdexTableName, livingdex.toMap());
  }

  deleteLivingdex(int id) async {
    var db = await _getDb();
    db.delete(livingdexTableName, where: "id = ?", whereArgs: [id]);
  }

  capturePokemon(int livingdexId, int pokemonId) async {
    var db = await _getDb();
    db.insert(capturedTableName, { 'livingdex_id': livingdexId, 'pokemon_id': pokemonId, });
  }

  releasePokemon(int livingdexId, int pokemonId) async {
    var db = await _getDb();
    db.delete(capturedTableName, where: "livingdex_id = ? AND pokemon_id = ?", whereArgs: [livingdexId, pokemonId]);
  }

/*
  /// Get all pokemons by livingdex Id, will return a list with all the pokemons captured in that livingdex
  Future<List<Pokemon>> getPokemonsByLivingdexId(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT $pokemonTableName.*'
            'FROM $pokemonTableName '
            'JOIN $capturedTableName '
            'ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id} '
            'AND $capturedTableName.livingdex_id = "$id" ');
    var pokemons = [];
    for(Map<String, dynamic> item in result) {
      pokemons.add(new Pokemon.fromMap(item));
    }
    return pokemons;
  }
*/

  Future<List<Pokemon>> getCapturedPokemons(int livingdexId) async {
    var db = await _getDb();
    var pokemonsMapList = await db.query('$pokemonTableName INNER JOIN $capturedTableName ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id}',
              where:'$capturedTableName.livingdex_id = ?', whereArgs: [livingdexId]);
    List<Pokemon> pokemons = [];
    for(Map<String, dynamic> item in pokemonsMapList) {
      pokemons.add(Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future<List<Pokemon>> getNationalDex(int gameId) async {
    var db = await _getDb();
    var pokemonsMapList = await db.query('$pokemonTableName INNER JOIN $pokemonGameTableName ON $pokemonGameTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id}',
        where:'$pokemonGameTableName.game_id = ?', whereArgs: [gameId]);
    List<Pokemon> pokemons = [];
    for(Map<String, dynamic> item in pokemonsMapList) {
      pokemons.add(Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }



}