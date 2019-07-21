import 'package:living_dex_tracker/data/LDTDatabase.dart';
import 'package:living_dex_tracker/model/Pokedex.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Game.dart';

class Repository {

  static final Repository _repo = new Repository._internal();

  LDTDatabase database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    database = LDTDatabase.get();
  }

  Future<Livingdex> getPokedexById(String id) async {
    Livingdex pokedex = await database.getPokedexById(id);
    List<Pokemon> pokemons = await database.getPokemonsByPokedexId(id);
    if(pokemons != null) {
      pokedex.pokemons = pokemons;
    }
    return pokedex;
  }

  Future<List<Livingdex>> getPokedexList() async {
    return await database.getAllPokedex();
  }

  createPokedex(String name, Game game, bool shiny) {
    var pokedex = Livingdex(name: name, game: game, shiny: shiny);
    return database.createPokedex(pokedex);
  }

  deletePokedex(String id) async {
    return database.deletePokedex(id);
  }
}