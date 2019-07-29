import 'package:meta/meta.dart';

class Game {
  static final db_id = "id";
  static final db_name = "name";

  int id;
  String name;

  Game({
    this.id,
    @required this.name,
  });

  Game.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      db_name: name,
    };
    if (id != null) {
      map[db_id] = id;
    }
    return map;
  }
}