import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Game.dart';
import 'package:living_dex_tracker/model/Pokedex.dart';

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
                  "${Pokemon.db_shiny_sprite_url} TEXT,"
                  ")");
          await db.execute(
              "CREATE TABLE $gameTableName ("
                  "id INTEGER PRIMARY KEY,"
                  "name TEXT"
                  ")");
          await db.execute("CREATE TABLE $livingdexTableName ("
              "${Livingdex.db_id} INTEGER PRIMARY KEY,"
              "${Livingdex.db_name} TEXT,"
              "${Livingdex.db_shiny} INTEGER,"
              "FOREIGN KEY(${Livingdex.db_gameId}) REFERENCES $gameTableName(${Game.db_id})"
              ")");
          await db.execute("CREATE TABLE $capturedTableName ("
              "id INTEGER PRIMARY KEY, "
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(livingdex_id) REFERENCES $livingdexTableName(${Livingdex.db_id})"
              ")");
          await db.execute("CREATE TABLE $pokemonGameTableName ("
              "id INTEGER PRIMARY KEY, "
              "regional_id INTEGER,"
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(game_id) REFERENCES $livingdexTableName(${Game.db_id})"
              ")");
        });
    didInit = true;


  }

  /// Get all pokemons by livingdex Id, will return a list with all the pokemons captured in that livingdex
  Future<List<Pokemon>> getPokemonsByLivingdexId(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
      'SELECT $pokemonTableName.*, $capturedTableName.id as captured'
      'FROM $pokemonTableName '
          'LEFT JOIN $capturedTableName '
              'ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id} '
              'AND $capturedTableName.livingdex_id = "$id" ');
    var pokemons = [];
    for(Map<String, dynamic> item in result) {
      pokemons.add(new Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future<Livingdex> getLivingdexById (String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * '
        'FROM $livingdexTableName '
        'WHERE $livingdexTableName.${Livingdex.db_id} = "$id" ');
    return new Livingdex.fromMap(result[0]);
  }

  Future<List<Livingdex>> getAllLivingdex() async {
    var db = await _getDb();
    var result = await db.rawQuery(
    'SELECT * '
    'FROM $livingdexTableName ');

    var livingdex = [];
    for(Map<String, dynamic> item in result) {
      livingdex.add(new Livingdex.fromMap(item));
    }
    return livingdex;
  }

  createPokedex(Livingdex livingdex) async {
    var db = await _getDb();
    Map<String, dynamic> row = livingdex.toMap();
    db.insert("$livingdexTableName", row);
  }

  deletePokedex(String id) async {
    var db = await _getDb();
    db.delete("$livingdexTableName", where: "id = ?", whereArgs: [id]);
  }

//  capturePokemon(String pokemonId, String pokedexId) async {
//    var db = await _getDb();
//    var row = {
//      db_name: name,
//      db_generation: generation,
//      db_shiny: shiny? 1:0,
//    };
//  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

}