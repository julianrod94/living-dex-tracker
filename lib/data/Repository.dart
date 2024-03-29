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

  Future<Livingdex> getLivingdex(int id) async {
    Livingdex livingdex = await database.getLivingdex(id);
    List<Pokemon> capturedPokemons = await database.getCapturedPokemons(id);
    List<Pokemon> nationalDex = await database.getNationalDex(livingdex.gameId);
    livingdex.pokemons = nationalDex.map((pokemon){
      pokemon.captured = capturedPokemons.contains(pokemon);
      return pokemon;
    }).toList();
    livingdex.game = await getGame(livingdex.gameId);
    return livingdex;
  }

  Future<List<Livingdex>> listLivingdexes() async {
    var livingdexes = await database.listLivingdexes();
    await Future.forEach(livingdexes, (livingdex) async => livingdex.game = await getGame(livingdex.gameId));
    return livingdexes;
  }

  createLivingdex(String name, int gameId, bool shiny, bool national) {
    var livingdex = Livingdex(name: name, gameId: gameId, shiny: shiny, national: national);
    return database.createLivingdex(livingdex);
  }

  deleteLivingdex(int id) async {
    return database.deleteLivingdex(id);
  }

  Future<List<Pokemon>> getAllPokemon() async {
    return database.getAllPokemon();
  }

  Future<List<Game>> listGames() async {
    return database.listGames();
  }

  Future<Game> getGame(int id) async {
    return database.getGame(id);
  }

  capturePokemon(livingdexId, pokemonId) async{
    return database.capturePokemon(livingdexId, pokemonId);
  }

  releasePokemon(livingdexId, pokemonId) async{
    return database.releasePokemon(livingdexId, pokemonId);
  }

  // updateLivingdex

}