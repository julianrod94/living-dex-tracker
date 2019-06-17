import 'package:meta/meta.dart';
import 'package:living_dex_tracker/model/Generation.dart';
import 'Pokemon.dart';

class Pokedex {
  static final db_id = "id";
  static final db_name = "name";
  static final db_generation = "generation";
  static final db_shiny = "shiny";

  int id;
  String name;
  Generation generation;
  bool shiny;
  List<Pokemon> pokemons = List();

  Pokedex({
    this.id,
    @required this.name,
    @required this.generation,
    @required this.shiny,
  });

  Pokedex.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    generation: Generation.values[map[db_generation]],
    shiny: map[db_shiny],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      db_name: name,
      db_generation: generation,
      db_shiny: shiny? 1:0,
    };
    if (id != null) {
      map[db_id] = id;
    }
    return map;
  }
}