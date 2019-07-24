import 'package:living_dex_tracker/data/LDTDatabase.dart';
import 'package:living_dex_tracker/model/Livingdex.dart';
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
    Livingdex livingdex = await database.getLivingdexById(id);
    List<Pokemon> pokemons = await database.getPokemonsByLivingdexId(id);
    if(pokemons != null) {
      livingdex.pokemons = pokemons;
    }
    return livingdex;
  }

  Future<List<Livingdex>> getLivingdexList() async {
    return await database.getAllLivingdex();
  }

  createLivingdex(String name, Game game, bool shiny) {
    var livingdex = Livingdex(name: name, game: game, shiny: shiny);
    return database.createLivingdex(livingdex);
  }

  deleteLivingdex(String id) async {
    return database.deleteLivingdex(id);
  }
}