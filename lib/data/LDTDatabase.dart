import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Pokedex.dart';

class LDTDatabase {
  static final LDTDatabase _lDTDatabase = new LDTDatabase._internal();

  final String pokemonTableName = "Pokemon";
  final String pokedexTableName = "Pokedex";
  final String capturedTableName = "Captured";

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
                  "${Pokemon.db_sprite_url} TEXT"
                  ")");
          await db.execute("CREATE TABLE $pokedexTableName ("
              "${Pokedex.db_id} INTEGER PRIMARY KEY, "
              "${Pokedex.db_name} TEXT, "
              "${Pokedex.db_generation} INTEGER, "
              "${Pokedex.db_shiny} INTEGER "
              ")");
          await db.execute("CREATE TABLE $capturedTableName ("
              "id INTEGER PRIMARY KEY, "
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(pokedex_id) REFERENCES $pokedexTableName(${Pokedex.db_id})"
              ")");
        });
    didInit = true;


  }

  /// Get all pokemons by pokedex Id, will return a list with all the pokemons found
  Future<List<Pokemon>> getPokemonsByPokedexId(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
      'SELECT $pokemonTableName.*, $capturedTableName.id as captured'
      'FROM $pokemonTableName '
          'LEFT JOIN $capturedTableName '
              'ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id} '
              'AND $capturedTableName.pokedex_id = "$id" ');
    var pokemons = [];
    for(Map<String, dynamic> item in result) {
      pokemons.add(new Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future<Pokedex> getPokedexById (String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * '
        'FROM $pokedexTableName '
        'WHERE $pokedexTableName.${Pokedex.db_id} = "$id" ');
    return new Pokedex.fromMap(result[0]);
  }

  Future<List<Pokedex>> getAllPokedex() async {
    var db = await _getDb();
    var result = await db.rawQuery(
    'SELECT * '
    'FROM $pokedexTableName ');

    var pokedexList = [];
    for(Map<String, dynamic> item in result) {
      pokedexList.add(new Pokedex.fromMap(item));
    }
    return pokedexList;
  }

  createPokedex(Pokedex pokedex) async {
    var db = await _getDb();
    Map<String, dynamic> row = pokedex.toMap();
    db.insert("$pokedexTableName", row);
  }

  deletePokedex(String id) async {
    var db = await _getDb();
    db.delete("$pokedexTableName", where: "id = ?", whereArgs: [id]);
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