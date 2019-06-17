import 'package:living_dex_tracker/data/LDTDatabase.dart';
import 'package:living_dex_tracker/model/Pokedex.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Generation.dart';

class Repository {

  static final Repository _repo = new Repository._internal();

  LDTDatabase database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    database = LDTDatabase.get();
  }

  Future<Pokedex> getPokedexById(String id) async {
    Pokedex pokedex = await database.getPokedexById(id);
    List<Pokemon> pokemons = await database.getPokemonsByPokedexId(id);
    if(pokemons != null) {
      pokedex.pokemons = pokemons;
    }
    return pokedex;
  }

  Future<List<Pokedex>> getPokedexList() async {
    return await database.getAllPokedex();
  }

  createPokedex(String name, Generation gen, bool shiny) {
    var pokedex = Pokedex(name: name, generation: gen, shiny: shiny);
    return database.createPokedex(pokedex);
  }

  deletePokedex(String id) async {
    return database.deletePokedex(id);
  }
}