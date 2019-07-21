import 'package:meta/meta.dart';

class Pokemon {
  static final db_id = "id";
  static final db_name = "name";
  static final db_captured = "captured";
  static final db_sprite_url = "sprite_url";
  static final db_shiny_sprite_url = "shiny_sprite_url";
  static final db_national_number = "national_number";

  int id;
  String name;
  bool captured;
  String spriteUrl;

  Pokemon({
    @required this.id,
    @required this.name,
    this.captured = false,
  });

  Pokemon.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    captured: map[db_captured] != null,
  );

  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_name: name,
    };
  }
}