import 'package:meta/meta.dart';
import 'package:living_dex_tracker/model/Game.dart';
import 'Pokemon.dart';

class Livingdex {
  static final db_id = "id";
  static final db_name = "name";
  static final db_gameId = "game_id";
  static final db_shiny = "shiny";

  int id;
  String name;
  Game game;
  bool shiny;
  List<Pokemon> pokemons = List();

  Livingdex({
    this.id,
    @required this.name,
    @required this.game,
    @required this.shiny,
  });

  Livingdex.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    game: map[db_gameId],
    shiny: map[db_shiny],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      db_name: name,
      db_gameId: game.id,
      db_shiny: shiny? 1:0,
    };
    if (id != null) {
      map[db_id] = id;
    }
    return map;
  }
}