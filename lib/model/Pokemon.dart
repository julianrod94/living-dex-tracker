import 'package:meta/meta.dart';

class Pokemon {
  static final db_id = "id";
  static final db_name = "name";
  static final db_sprite_url = "sprite_url";
  static final db_shiny_sprite_url = "shiny_sprite_url";
  static final db_national_number = "national_number";

  int id;
  String name;
  String spriteUrl;
  String shinySpriteUrl;
  int nationalNumber;
  int regionalNumber;
  bool captured;

  Pokemon({
    @required this.id,
    @required this.name,
    @required this.spriteUrl,
    @required this.shinySpriteUrl,
    @required this.nationalNumber,
    this.regionalNumber,
    this.captured,
  });

  Pokemon.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    nationalNumber: map[db_national_number],
    spriteUrl: 'assets/regular/${map[db_name].toString().toLowerCase()}.png',
    shinySpriteUrl: 'assets/shiny/${map[db_name]}.png',
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      db_name: name,
      db_national_number: nationalNumber,
      db_sprite_url: spriteUrl,
      db_shiny_sprite_url: shinySpriteUrl,
    };
    if (id != null) {
      map[db_id] = id;
    }
    return map;
  }
}