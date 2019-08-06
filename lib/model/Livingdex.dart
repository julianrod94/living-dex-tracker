import 'package:meta/meta.dart';
import 'package:living_dex_tracker/model/Game.dart';
import 'Pokemon.dart';

class Livingdex {
  static final db_id = "id";
  static final db_name = "name";
  static final db_shiny = "shiny";
  static final db_gameId = "game_id";
  static final db_national = "national";

  int id;
  String name;
  int gameId;
  Game game;
  bool shiny;
  bool national;
  List<Pokemon> pokemons;

  Livingdex({
    this.id,
    @required this.name,
    @required this.gameId,
    @required this.shiny,
    @required this.national,
  });

  Livingdex.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    gameId: map[db_gameId],
    shiny: map[db_shiny]==1,
    national: map[db_national]==1,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      db_name: name,
      db_gameId: gameId,
      db_shiny: shiny? 1:0,
      db_national: national? 1:0,
    };
    if (id != null) {
      map[db_id] = id;
    }
    return map;
  }
}