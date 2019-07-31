import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/model/Game.dart';
import 'package:living_dex_tracker/model/Livingdex.dart';

class LDTDatabase {
  static final LDTDatabase _lDTDatabase = new LDTDatabase._internal();

  final String pokemonTableName = "Pokemon";
  final String livingdexTableName = "Livingdex";
  final String capturedTableName = "Captured";
  final String gameTableName = "Game";
  final String pokemonGameTableName = "Pokemon_Game";

  Database db;

  bool didInit = false;

  static LDTDatabase get() {
    return _lDTDatabase;
  }

  LDTDatabase._internal();


  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }


  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "living_dex_tracker_database.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          var batch = db.batch();
              db.execute(
                  "CREATE TABLE $pokemonTableName ("
                      "${Pokemon.db_id} INTEGER PRIMARY KEY,"
                      "${Pokemon.db_name} TEXT,"
                      "${Pokemon.db_national_number} INTEGER,"
                      "${Pokemon.db_sprite_url} TEXT,"
                      "${Pokemon.db_shiny_sprite_url} TEXT"
                      ")");
              db.execute(
                  "CREATE TABLE $gameTableName ("
                      "${Game.db_id} INTEGER PRIMARY KEY,"
                      "${Game.db_name} TEXT"
                      ")");
              db.execute("CREATE TABLE $livingdexTableName ("
                  "${Livingdex.db_id} INTEGER PRIMARY KEY,"
                  "${Livingdex.db_name} TEXT,"
                  "${Livingdex.db_shiny} INTEGER,"
                  "${Livingdex.db_national} INTEGER,"
                  "${Livingdex.db_gameId} INTEGER,"
                  "FOREIGN KEY(${Livingdex.db_gameId}) REFERENCES $gameTableName(${Game.db_id})"
                  ")");
              db.execute("CREATE TABLE $capturedTableName ("
                  "id INTEGER PRIMARY KEY, "
                  "pokemon_id INTEGER,"
                  "livingdex_id INTEGER,"
                  "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
                  "FOREIGN KEY(livingdex_id) REFERENCES $livingdexTableName(${Livingdex.db_id})"
                  ")");
              db.execute("CREATE TABLE $pokemonGameTableName ("
                  "id INTEGER PRIMARY KEY, "
                  "regional_id INTEGER,"
                  "pokemon_id INTEGER,"
                  "game_id INTEGER,"
                  "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
                  "FOREIGN KEY(game_id) REFERENCES $livingdexTableName(${Game.db_id})"
                  ")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(1,\"Bulbasaur\", \"assets/regular/bulbasaur.png\", \"assets/shiny/bulbasaur.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(2,\"Ivysaur\", \"assets/regular/ivysaur.png\", \"assets/shiny/ivysaur.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(3,\"Venusaur\", \"assets/regular/venusaur.png\", \"assets/shiny/venusaur.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(4,\"Charmander\", \"assets/regular/charmander.png\", \"assets/shiny/charmander.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(5,\"Charmeleon\", \"assets/regular/charmeleon.png\", \"assets/shiny/charmeleon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(6,\"Charizard\", \"assets/regular/charizard.png\", \"assets/shiny/charizard.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(7,\"Squirtle\", \"assets/regular/squirtle.png\", \"assets/shiny/squirtle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(8,\"Wartortle\", \"assets/regular/wartortle.png\", \"assets/shiny/wartortle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(9,\"Blastoise\", \"assets/regular/blastoise.png\", \"assets/shiny/blastoise.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(10,\"Caterpie\", \"assets/regular/caterpie.png\", \"assets/shiny/caterpie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(11,\"Metapod\", \"assets/regular/metapod.png\", \"assets/shiny/metapod.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(12,\"Butterfree\", \"assets/regular/butterfree.png\", \"assets/shiny/butterfree.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(13,\"Weedle\", \"assets/regular/weedle.png\", \"assets/shiny/weedle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(14,\"Kakuna\", \"assets/regular/kakuna.png\", \"assets/shiny/kakuna.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(15,\"Beedrill\", \"assets/regular/beedrill.png\", \"assets/shiny/beedrill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(16,\"Pidgey\", \"assets/regular/pidgey.png\", \"assets/shiny/pidgey.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(17,\"Pidgeotto\", \"assets/regular/pidgeotto.png\", \"assets/shiny/pidgeotto.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(18,\"Pidgeot\", \"assets/regular/pidgeot.png\", \"assets/shiny/pidgeot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(19,\"Rattata\", \"assets/regular/rattata.png\", \"assets/shiny/rattata.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(20,\"Raticate\", \"assets/regular/raticate.png\", \"assets/shiny/raticate.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(21,\"Spearow\", \"assets/regular/spearow.png\", \"assets/shiny/spearow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(22,\"Fearow\", \"assets/regular/fearow.png\", \"assets/shiny/fearow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(23,\"Ekans\", \"assets/regular/ekans.png\", \"assets/shiny/ekans.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(24,\"Arbok\", \"assets/regular/arbok.png\", \"assets/shiny/arbok.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(25,\"Pikachu\", \"assets/regular/pikachu.png\", \"assets/shiny/pikachu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(26,\"Raichu\", \"assets/regular/raichu.png\", \"assets/shiny/raichu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(27,\"Sandshrew\", \"assets/regular/sandshrew.png\", \"assets/shiny/sandshrew.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(28,\"Sandslash\", \"assets/regular/sandslash.png\", \"assets/shiny/sandslash.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(29,\"Nidoran♀\", \"assets/regular/nidoran-f.png\", \"assets/shiny/nidoran-f.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(30,\"Nidorina\", \"assets/regular/nidorina.png\", \"assets/shiny/nidorina.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(31,\"Nidoqueen\", \"assets/regular/nidoqueen.png\", \"assets/shiny/nidoqueen.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(32,\"Nidoran♂\", \"assets/regular/nidoran-m.png\", \"assets/shiny/nidoran-m.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(33,\"Nidorino\", \"assets/regular/nidorino.png\", \"assets/shiny/nidorino.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(34,\"Nidoking\", \"assets/regular/nidoking.png\", \"assets/shiny/nidoking.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(35,\"Clefairy\", \"assets/regular/clefairy.png\", \"assets/shiny/clefairy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(36,\"Clefable\", \"assets/regular/clefable.png\", \"assets/shiny/clefable.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(37,\"Vulpix\", \"assets/regular/vulpix.png\", \"assets/shiny/vulpix.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(38,\"Ninetales\", \"assets/regular/ninetales.png\", \"assets/shiny/ninetales.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(39,\"Jigglypuff\", \"assets/regular/jigglypuff.png\", \"assets/shiny/jigglypuff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(40,\"Wigglytuff\", \"assets/regular/wigglytuff.png\", \"assets/shiny/wigglytuff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(41,\"Zubat\", \"assets/regular/zubat.png\", \"assets/shiny/zubat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(42,\"Golbat\", \"assets/regular/golbat.png\", \"assets/shiny/golbat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(43,\"Oddish\", \"assets/regular/oddish.png\", \"assets/shiny/oddish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(44,\"Gloom\", \"assets/regular/gloom.png\", \"assets/shiny/gloom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(45,\"Vileplume\", \"assets/regular/vileplume.png\", \"assets/shiny/vileplume.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(46,\"Paras\", \"assets/regular/paras.png\", \"assets/shiny/paras.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(47,\"Parasect\", \"assets/regular/parasect.png\", \"assets/shiny/parasect.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(48,\"Venonat\", \"assets/regular/venonat.png\", \"assets/shiny/venonat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(49,\"Venomoth\", \"assets/regular/venomoth.png\", \"assets/shiny/venomoth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(50,\"Diglett\", \"assets/regular/diglett.png\", \"assets/shiny/diglett.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(51,\"Dugtrio\", \"assets/regular/dugtrio.png\", \"assets/shiny/dugtrio.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(52,\"Meowth\", \"assets/regular/meowth.png\", \"assets/shiny/meowth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(53,\"Persian\", \"assets/regular/persian.png\", \"assets/shiny/persian.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(54,\"Psyduck\", \"assets/regular/psyduck.png\", \"assets/shiny/psyduck.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(55,\"Golduck\", \"assets/regular/golduck.png\", \"assets/shiny/golduck.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(56,\"Mankey\", \"assets/regular/mankey.png\", \"assets/shiny/mankey.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(57,\"Primeape\", \"assets/regular/primeape.png\", \"assets/shiny/primeape.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(58,\"Growlithe\", \"assets/regular/growlithe.png\", \"assets/shiny/growlithe.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(59,\"Arcanine\", \"assets/regular/arcanine.png\", \"assets/shiny/arcanine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(60,\"Poliwag\", \"assets/regular/poliwag.png\", \"assets/shiny/poliwag.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(61,\"Poliwhirl\", \"assets/regular/poliwhirl.png\", \"assets/shiny/poliwhirl.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(62,\"Poliwrath\", \"assets/regular/poliwrath.png\", \"assets/shiny/poliwrath.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(63,\"Abra\", \"assets/regular/abra.png\", \"assets/shiny/abra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(64,\"Kadabra\", \"assets/regular/kadabra.png\", \"assets/shiny/kadabra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(65,\"Alakazam\", \"assets/regular/alakazam.png\", \"assets/shiny/alakazam.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(66,\"Machop\", \"assets/regular/machop.png\", \"assets/shiny/machop.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(67,\"Machoke\", \"assets/regular/machoke.png\", \"assets/shiny/machoke.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(68,\"Machamp\", \"assets/regular/machamp.png\", \"assets/shiny/machamp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(69,\"Bellsprout\", \"assets/regular/bellsprout.png\", \"assets/shiny/bellsprout.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(70,\"Weepinbell\", \"assets/regular/weepinbell.png\", \"assets/shiny/weepinbell.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(71,\"Victreebel\", \"assets/regular/victreebel.png\", \"assets/shiny/victreebel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(72,\"Tentacool\", \"assets/regular/tentacool.png\", \"assets/shiny/tentacool.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(73,\"Tentacruel\", \"assets/regular/tentacruel.png\", \"assets/shiny/tentacruel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(74,\"Geodude\", \"assets/regular/geodude.png\", \"assets/shiny/geodude.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(75,\"Graveler\", \"assets/regular/graveler.png\", \"assets/shiny/graveler.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(76,\"Golem\", \"assets/regular/golem.png\", \"assets/shiny/golem.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(77,\"Ponyta\", \"assets/regular/ponyta.png\", \"assets/shiny/ponyta.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(78,\"Rapidash\", \"assets/regular/rapidash.png\", \"assets/shiny/rapidash.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(79,\"Slowpoke\", \"assets/regular/slowpoke.png\", \"assets/shiny/slowpoke.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(80,\"Slowbro\", \"assets/regular/slowbro.png\", \"assets/shiny/slowbro.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(81,\"Magnemite\", \"assets/regular/magnemite.png\", \"assets/shiny/magnemite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(82,\"Magneton\", \"assets/regular/magneton.png\", \"assets/shiny/magneton.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(83,\"Farfetc\", \"assets/regular/farfetc.png\", \"assets/shiny/farfetc.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(84,\"Doduo\", \"assets/regular/doduo.png\", \"assets/shiny/doduo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(85,\"Dodrio\", \"assets/regular/dodrio.png\", \"assets/shiny/dodrio.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(86,\"Seel\", \"assets/regular/seel.png\", \"assets/shiny/seel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(87,\"Dewgong\", \"assets/regular/dewgong.png\", \"assets/shiny/dewgong.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(88,\"Grimer\", \"assets/regular/grimer.png\", \"assets/shiny/grimer.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(89,\"Muk\", \"assets/regular/muk.png\", \"assets/shiny/muk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(90,\"Shellder\", \"assets/regular/shellder.png\", \"assets/shiny/shellder.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(91,\"Cloyster\", \"assets/regular/cloyster.png\", \"assets/shiny/cloyster.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(92,\"Gastly\", \"assets/regular/gastly.png\", \"assets/shiny/gastly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(93,\"Haunter\", \"assets/regular/haunter.png\", \"assets/shiny/haunter.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(94,\"Gengar\", \"assets/regular/gengar.png\", \"assets/shiny/gengar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(95,\"Onix\", \"assets/regular/onix.png\", \"assets/shiny/onix.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(96,\"Drowzee\", \"assets/regular/drowzee.png\", \"assets/shiny/drowzee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(97,\"Hypno\", \"assets/regular/hypno.png\", \"assets/shiny/hypno.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(98,\"Krabby\", \"assets/regular/krabby.png\", \"assets/shiny/krabby.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(99,\"Kingler\", \"assets/regular/kingler.png\", \"assets/shiny/kingler.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(100,\"Voltorb\", \"assets/regular/voltorb.png\", \"assets/shiny/voltorb.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(101,\"Electrode\", \"assets/regular/electrode.png\", \"assets/shiny/electrode.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(102,\"Exeggcute\", \"assets/regular/exeggcute.png\", \"assets/shiny/exeggcute.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(103,\"Exeggutor\", \"assets/regular/exeggutor.png\", \"assets/shiny/exeggutor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(104,\"Cubone\", \"assets/regular/cubone.png\", \"assets/shiny/cubone.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(105,\"Marowak\", \"assets/regular/marowak.png\", \"assets/shiny/marowak.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(106,\"Hitmonlee\", \"assets/regular/hitmonlee.png\", \"assets/shiny/hitmonlee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(107,\"Hitmonchan\", \"assets/regular/hitmonchan.png\", \"assets/shiny/hitmonchan.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(108,\"Lickitung\", \"assets/regular/lickitung.png\", \"assets/shiny/lickitung.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(109,\"Koffing\", \"assets/regular/koffing.png\", \"assets/shiny/koffing.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(110,\"Weezing\", \"assets/regular/weezing.png\", \"assets/shiny/weezing.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(111,\"Rhyhorn\", \"assets/regular/rhyhorn.png\", \"assets/shiny/rhyhorn.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(112,\"Rhydon\", \"assets/regular/rhydon.png\", \"assets/shiny/rhydon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(113,\"Chansey\", \"assets/regular/chansey.png\", \"assets/shiny/chansey.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(114,\"Tangela\", \"assets/regular/tangela.png\", \"assets/shiny/tangela.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(115,\"Kangaskhan\", \"assets/regular/kangaskhan.png\", \"assets/shiny/kangaskhan.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(116,\"Horsea\", \"assets/regular/horsea.png\", \"assets/shiny/horsea.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(117,\"Seadra\", \"assets/regular/seadra.png\", \"assets/shiny/seadra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(118,\"Goldeen\", \"assets/regular/goldeen.png\", \"assets/shiny/goldeen.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(119,\"Seaking\", \"assets/regular/seaking.png\", \"assets/shiny/seaking.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(120,\"Staryu\", \"assets/regular/staryu.png\", \"assets/shiny/staryu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(121,\"Starmie\", \"assets/regular/starmie.png\", \"assets/shiny/starmie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(122,\"Mr.Mime\", \"assets/regular/mr-mime.png\", \"assets/shiny/mr-mime.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(123,\"Scyther\", \"assets/regular/scyther.png\", \"assets/shiny/scyther.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(124,\"Jynx\", \"assets/regular/jynx.png\", \"assets/shiny/jynx.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(125,\"Electabuzz\", \"assets/regular/electabuzz.png\", \"assets/shiny/electabuzz.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(126,\"Magmar\", \"assets/regular/magmar.png\", \"assets/shiny/magmar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(127,\"Pinsir\", \"assets/regular/pinsir.png\", \"assets/shiny/pinsir.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(128,\"Tauros\", \"assets/regular/tauros.png\", \"assets/shiny/tauros.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(129,\"Magikarp\", \"assets/regular/magikarp.png\", \"assets/shiny/magikarp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(130,\"Gyarados\", \"assets/regular/gyarados.png\", \"assets/shiny/gyarados.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(131,\"Lapras\", \"assets/regular/lapras.png\", \"assets/shiny/lapras.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(132,\"Ditto\", \"assets/regular/ditto.png\", \"assets/shiny/ditto.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(133,\"Eevee\", \"assets/regular/eevee.png\", \"assets/shiny/eevee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(134,\"Vaporeon\", \"assets/regular/vaporeon.png\", \"assets/shiny/vaporeon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(135,\"Jolteon\", \"assets/regular/jolteon.png\", \"assets/shiny/jolteon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(136,\"Flareon\", \"assets/regular/flareon.png\", \"assets/shiny/flareon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(137,\"Porygon\", \"assets/regular/porygon.png\", \"assets/shiny/porygon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(138,\"Omanyte\", \"assets/regular/omanyte.png\", \"assets/shiny/omanyte.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(139,\"Omastar\", \"assets/regular/omastar.png\", \"assets/shiny/omastar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(140,\"Kabuto\", \"assets/regular/kabuto.png\", \"assets/shiny/kabuto.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(141,\"Kabutops\", \"assets/regular/kabutops.png\", \"assets/shiny/kabutops.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(142,\"Aerodactyl\", \"assets/regular/aerodactyl.png\", \"assets/shiny/aerodactyl.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(143,\"Snorlax\", \"assets/regular/snorlax.png\", \"assets/shiny/snorlax.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(144,\"Articuno\", \"assets/regular/articuno.png\", \"assets/shiny/articuno.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(145,\"Zapdos\", \"assets/regular/zapdos.png\", \"assets/shiny/zapdos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(146,\"Moltres\", \"assets/regular/moltres.png\", \"assets/shiny/moltres.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(147,\"Dratini\", \"assets/regular/dratini.png\", \"assets/shiny/dratini.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(148,\"Dragonair\", \"assets/regular/dragonair.png\", \"assets/shiny/dragonair.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(149,\"Dragonite\", \"assets/regular/dragonite.png\", \"assets/shiny/dragonite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(150,\"Mewtwo\", \"assets/regular/mewtwo.png\", \"assets/shiny/mewtwo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(151,\"Mew\", \"assets/regular/mew.png\", \"assets/shiny/mew.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(152,\"Chikorita\", \"assets/regular/chikorita.png\", \"assets/shiny/chikorita.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(153,\"Bayleef\", \"assets/regular/bayleef.png\", \"assets/shiny/bayleef.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(154,\"Meganium\", \"assets/regular/meganium.png\", \"assets/shiny/meganium.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(155,\"Cyndaquil\", \"assets/regular/cyndaquil.png\", \"assets/shiny/cyndaquil.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(156,\"Quilava\", \"assets/regular/quilava.png\", \"assets/shiny/quilava.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(157,\"Typhlosion\", \"assets/regular/typhlosion.png\", \"assets/shiny/typhlosion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(158,\"Totodile\", \"assets/regular/totodile.png\", \"assets/shiny/totodile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(159,\"Croconaw\", \"assets/regular/croconaw.png\", \"assets/shiny/croconaw.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(160,\"Feraligatr\", \"assets/regular/feraligatr.png\", \"assets/shiny/feraligatr.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(161,\"Sentret\", \"assets/regular/sentret.png\", \"assets/shiny/sentret.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(162,\"Furret\", \"assets/regular/furret.png\", \"assets/shiny/furret.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(163,\"Hoothoot\", \"assets/regular/hoothoot.png\", \"assets/shiny/hoothoot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(164,\"Noctowl\", \"assets/regular/noctowl.png\", \"assets/shiny/noctowl.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(165,\"Ledyba\", \"assets/regular/ledyba.png\", \"assets/shiny/ledyba.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(166,\"Ledian\", \"assets/regular/ledian.png\", \"assets/shiny/ledian.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(167,\"Spinarak\", \"assets/regular/spinarak.png\", \"assets/shiny/spinarak.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(168,\"Ariados\", \"assets/regular/ariados.png\", \"assets/shiny/ariados.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(169,\"Crobat\", \"assets/regular/crobat.png\", \"assets/shiny/crobat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(170,\"Chinchou\", \"assets/regular/chinchou.png\", \"assets/shiny/chinchou.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(171,\"Lanturn\", \"assets/regular/lanturn.png\", \"assets/shiny/lanturn.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(172,\"Pichu\", \"assets/regular/pichu.png\", \"assets/shiny/pichu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(173,\"Cleffa\", \"assets/regular/cleffa.png\", \"assets/shiny/cleffa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(174,\"Igglybuff\", \"assets/regular/igglybuff.png\", \"assets/shiny/igglybuff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(175,\"Togepi\", \"assets/regular/togepi.png\", \"assets/shiny/togepi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(176,\"Togetic\", \"assets/regular/togetic.png\", \"assets/shiny/togetic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(177,\"Natu\", \"assets/regular/natu.png\", \"assets/shiny/natu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(178,\"Xatu\", \"assets/regular/xatu.png\", \"assets/shiny/xatu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(179,\"Mareep\", \"assets/regular/mareep.png\", \"assets/shiny/mareep.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(180,\"Flaaffy\", \"assets/regular/flaaffy.png\", \"assets/shiny/flaaffy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(181,\"Ampharos\", \"assets/regular/ampharos.png\", \"assets/shiny/ampharos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(182,\"Bellossom\", \"assets/regular/bellossom.png\", \"assets/shiny/bellossom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(183,\"Marill\", \"assets/regular/marill.png\", \"assets/shiny/marill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(184,\"Azumarill\", \"assets/regular/azumarill.png\", \"assets/shiny/azumarill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(185,\"Sudowoodo\", \"assets/regular/sudowoodo.png\", \"assets/shiny/sudowoodo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(186,\"Politoed\", \"assets/regular/politoed.png\", \"assets/shiny/politoed.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(187,\"Hoppip\", \"assets/regular/hoppip.png\", \"assets/shiny/hoppip.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(188,\"Skiploom\", \"assets/regular/skiploom.png\", \"assets/shiny/skiploom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(189,\"Jumpluff\", \"assets/regular/jumpluff.png\", \"assets/shiny/jumpluff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(190,\"Aipom\", \"assets/regular/aipom.png\", \"assets/shiny/aipom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(191,\"Sunkern\", \"assets/regular/sunkern.png\", \"assets/shiny/sunkern.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(192,\"Sunflora\", \"assets/regular/sunflora.png\", \"assets/shiny/sunflora.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(193,\"Yanma\", \"assets/regular/yanma.png\", \"assets/shiny/yanma.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(194,\"Wooper\", \"assets/regular/wooper.png\", \"assets/shiny/wooper.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(195,\"Quagsire\", \"assets/regular/quagsire.png\", \"assets/shiny/quagsire.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(196,\"Espeon\", \"assets/regular/espeon.png\", \"assets/shiny/espeon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(197,\"Umbreon\", \"assets/regular/umbreon.png\", \"assets/shiny/umbreon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(198,\"Murkrow\", \"assets/regular/murkrow.png\", \"assets/shiny/murkrow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(199,\"Slowking\", \"assets/regular/slowking.png\", \"assets/shiny/slowking.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(200,\"Misdreavus\", \"assets/regular/misdreavus.png\", \"assets/shiny/misdreavus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(201,\"Unown\", \"assets/regular/unown.png\", \"assets/shiny/unown.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(202,\"Wobbuffet\", \"assets/regular/wobbuffet.png\", \"assets/shiny/wobbuffet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(203,\"Girafarig\", \"assets/regular/girafarig.png\", \"assets/shiny/girafarig.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(204,\"Pineco\", \"assets/regular/pineco.png\", \"assets/shiny/pineco.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(205,\"Forretress\", \"assets/regular/forretress.png\", \"assets/shiny/forretress.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(206,\"Dunsparce\", \"assets/regular/dunsparce.png\", \"assets/shiny/dunsparce.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(207,\"Gligar\", \"assets/regular/gligar.png\", \"assets/shiny/gligar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(208,\"Steelix\", \"assets/regular/steelix.png\", \"assets/shiny/steelix.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(209,\"Snubbull\", \"assets/regular/snubbull.png\", \"assets/shiny/snubbull.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(210,\"Granbull\", \"assets/regular/granbull.png\", \"assets/shiny/granbull.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(211,\"Qwilfish\", \"assets/regular/qwilfish.png\", \"assets/shiny/qwilfish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(212,\"Scizor\", \"assets/regular/scizor.png\", \"assets/shiny/scizor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(213,\"Shuckle\", \"assets/regular/shuckle.png\", \"assets/shiny/shuckle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(214,\"Heracross\", \"assets/regular/heracross.png\", \"assets/shiny/heracross.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(215,\"Sneasel\", \"assets/regular/sneasel.png\", \"assets/shiny/sneasel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(216,\"Teddiursa\", \"assets/regular/teddiursa.png\", \"assets/shiny/teddiursa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(217,\"Ursaring\", \"assets/regular/ursaring.png\", \"assets/shiny/ursaring.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(218,\"Slugma\", \"assets/regular/slugma.png\", \"assets/shiny/slugma.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(219,\"Magcargo\", \"assets/regular/magcargo.png\", \"assets/shiny/magcargo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(220,\"Swinub\", \"assets/regular/swinub.png\", \"assets/shiny/swinub.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(221,\"Piloswine\", \"assets/regular/piloswine.png\", \"assets/shiny/piloswine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(222,\"Corsola\", \"assets/regular/corsola.png\", \"assets/shiny/corsola.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(223,\"Remoraid\", \"assets/regular/remoraid.png\", \"assets/shiny/remoraid.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(224,\"Octillery\", \"assets/regular/octillery.png\", \"assets/shiny/octillery.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(225,\"Delibird\", \"assets/regular/delibird.png\", \"assets/shiny/delibird.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(226,\"Mantine\", \"assets/regular/mantine.png\", \"assets/shiny/mantine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(227,\"Skarmory\", \"assets/regular/skarmory.png\", \"assets/shiny/skarmory.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(228,\"Houndour\", \"assets/regular/houndour.png\", \"assets/shiny/houndour.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(229,\"Houndoom\", \"assets/regular/houndoom.png\", \"assets/shiny/houndoom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(230,\"Kingdra\", \"assets/regular/kingdra.png\", \"assets/shiny/kingdra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(231,\"Phanpy\", \"assets/regular/phanpy.png\", \"assets/shiny/phanpy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(232,\"Donphan\", \"assets/regular/donphan.png\", \"assets/shiny/donphan.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(233,\"Porygon2\", \"assets/regular/porygon2.png\", \"assets/shiny/porygon2.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(234,\"Stantler\", \"assets/regular/stantler.png\", \"assets/shiny/stantler.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(235,\"Smeargle\", \"assets/regular/smeargle.png\", \"assets/shiny/smeargle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(236,\"Tyrogue\", \"assets/regular/tyrogue.png\", \"assets/shiny/tyrogue.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(237,\"Hitmontop\", \"assets/regular/hitmontop.png\", \"assets/shiny/hitmontop.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(238,\"Smoochum\", \"assets/regular/smoochum.png\", \"assets/shiny/smoochum.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(239,\"Elekid\", \"assets/regular/elekid.png\", \"assets/shiny/elekid.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(240,\"Magby\", \"assets/regular/magby.png\", \"assets/shiny/magby.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(241,\"Miltank\", \"assets/regular/miltank.png\", \"assets/shiny/miltank.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(242,\"Blissey\", \"assets/regular/blissey.png\", \"assets/shiny/blissey.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(243,\"Raikou\", \"assets/regular/raikou.png\", \"assets/shiny/raikou.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(244,\"Entei\", \"assets/regular/entei.png\", \"assets/shiny/entei.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(245,\"Suicune\", \"assets/regular/suicune.png\", \"assets/shiny/suicune.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(246,\"Larvitar\", \"assets/regular/larvitar.png\", \"assets/shiny/larvitar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(247,\"Pupitar\", \"assets/regular/pupitar.png\", \"assets/shiny/pupitar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(248,\"Tyranitar\", \"assets/regular/tyranitar.png\", \"assets/shiny/tyranitar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(249,\"Lugia\", \"assets/regular/lugia.png\", \"assets/shiny/lugia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(250,\"Ho-oh\", \"assets/regular/ho-oh.png\", \"assets/shiny/ho-oh.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(251,\"Celebi\", \"assets/regular/celebi.png\", \"assets/shiny/celebi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(252,\"Treecko\", \"assets/regular/treecko.png\", \"assets/shiny/treecko.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(253,\"Grovyle\", \"assets/regular/grovyle.png\", \"assets/shiny/grovyle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(254,\"Sceptile\", \"assets/regular/sceptile.png\", \"assets/shiny/sceptile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(255,\"Torchic\", \"assets/regular/torchic.png\", \"assets/shiny/torchic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(256,\"Combusken\", \"assets/regular/combusken.png\", \"assets/shiny/combusken.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(257,\"Blaziken\", \"assets/regular/blaziken.png\", \"assets/shiny/blaziken.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(258,\"Mudkip\", \"assets/regular/mudkip.png\", \"assets/shiny/mudkip.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(259,\"Marshtomp\", \"assets/regular/marshtomp.png\", \"assets/shiny/marshtomp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(260,\"Swampert\", \"assets/regular/swampert.png\", \"assets/shiny/swampert.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(261,\"Poochyena\", \"assets/regular/poochyena.png\", \"assets/shiny/poochyena.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(262,\"Mightyena\", \"assets/regular/mightyena.png\", \"assets/shiny/mightyena.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(263,\"Zigzagoon\", \"assets/regular/zigzagoon.png\", \"assets/shiny/zigzagoon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(264,\"Linoone\", \"assets/regular/linoone.png\", \"assets/shiny/linoone.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(265,\"Wurmple\", \"assets/regular/wurmple.png\", \"assets/shiny/wurmple.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(266,\"Silcoon\", \"assets/regular/silcoon.png\", \"assets/shiny/silcoon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(267,\"Beautifly\", \"assets/regular/beautifly.png\", \"assets/shiny/beautifly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(268,\"Cascoon\", \"assets/regular/cascoon.png\", \"assets/shiny/cascoon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(269,\"Dustox\", \"assets/regular/dustox.png\", \"assets/shiny/dustox.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(270,\"Lotad\", \"assets/regular/lotad.png\", \"assets/shiny/lotad.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(271,\"Lombre\", \"assets/regular/lombre.png\", \"assets/shiny/lombre.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(272,\"Ludicolo\", \"assets/regular/ludicolo.png\", \"assets/shiny/ludicolo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(273,\"Seedot\", \"assets/regular/seedot.png\", \"assets/shiny/seedot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(274,\"Nuzleaf\", \"assets/regular/nuzleaf.png\", \"assets/shiny/nuzleaf.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(275,\"Shiftry\", \"assets/regular/shiftry.png\", \"assets/shiny/shiftry.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(276,\"Taillow\", \"assets/regular/taillow.png\", \"assets/shiny/taillow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(277,\"Swellow\", \"assets/regular/swellow.png\", \"assets/shiny/swellow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(278,\"Wingull\", \"assets/regular/wingull.png\", \"assets/shiny/wingull.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(279,\"Pelipper\", \"assets/regular/pelipper.png\", \"assets/shiny/pelipper.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(280,\"Ralts\", \"assets/regular/ralts.png\", \"assets/shiny/ralts.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(281,\"Kirlia\", \"assets/regular/kirlia.png\", \"assets/shiny/kirlia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(282,\"Gardevoir\", \"assets/regular/gardevoir.png\", \"assets/shiny/gardevoir.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(283,\"Surskit\", \"assets/regular/surskit.png\", \"assets/shiny/surskit.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(284,\"Masquerain\", \"assets/regular/masquerain.png\", \"assets/shiny/masquerain.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(285,\"Shroomish\", \"assets/regular/shroomish.png\", \"assets/shiny/shroomish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(286,\"Breloom\", \"assets/regular/breloom.png\", \"assets/shiny/breloom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(287,\"Slakoth\", \"assets/regular/slakoth.png\", \"assets/shiny/slakoth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(288,\"Vigoroth\", \"assets/regular/vigoroth.png\", \"assets/shiny/vigoroth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(289,\"Slaking\", \"assets/regular/slaking.png\", \"assets/shiny/slaking.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(290,\"Nincada\", \"assets/regular/nincada.png\", \"assets/shiny/nincada.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(291,\"Ninjask\", \"assets/regular/ninjask.png\", \"assets/shiny/ninjask.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(292,\"Shedinja\", \"assets/regular/shedinja.png\", \"assets/shiny/shedinja.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(293,\"Whismur\", \"assets/regular/whismur.png\", \"assets/shiny/whismur.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(294,\"Loudred\", \"assets/regular/loudred.png\", \"assets/shiny/loudred.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(295,\"Exploud\", \"assets/regular/exploud.png\", \"assets/shiny/exploud.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(296,\"Makuhita\", \"assets/regular/makuhita.png\", \"assets/shiny/makuhita.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(297,\"Hariyama\", \"assets/regular/hariyama.png\", \"assets/shiny/hariyama.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(298,\"Azurill\", \"assets/regular/azurill.png\", \"assets/shiny/azurill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(299,\"Nosepass\", \"assets/regular/nosepass.png\", \"assets/shiny/nosepass.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(300,\"Skitty\", \"assets/regular/skitty.png\", \"assets/shiny/skitty.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(301,\"Delcatty\", \"assets/regular/delcatty.png\", \"assets/shiny/delcatty.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(302,\"Sableye\", \"assets/regular/sableye.png\", \"assets/shiny/sableye.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(303,\"Mawile\", \"assets/regular/mawile.png\", \"assets/shiny/mawile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(304,\"Aron\", \"assets/regular/aron.png\", \"assets/shiny/aron.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(305,\"Lairon\", \"assets/regular/lairon.png\", \"assets/shiny/lairon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(306,\"Aggron\", \"assets/regular/aggron.png\", \"assets/shiny/aggron.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(307,\"Meditite\", \"assets/regular/meditite.png\", \"assets/shiny/meditite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(308,\"Medicham\", \"assets/regular/medicham.png\", \"assets/shiny/medicham.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(309,\"Electrike\", \"assets/regular/electrike.png\", \"assets/shiny/electrike.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(310,\"Manectric\", \"assets/regular/manectric.png\", \"assets/shiny/manectric.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(311,\"Plusle\", \"assets/regular/plusle.png\", \"assets/shiny/plusle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(312,\"Minun\", \"assets/regular/minun.png\", \"assets/shiny/minun.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(313,\"Volbeat\", \"assets/regular/volbeat.png\", \"assets/shiny/volbeat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(314,\"Illumise\", \"assets/regular/illumise.png\", \"assets/shiny/illumise.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(315,\"Roselia\", \"assets/regular/roselia.png\", \"assets/shiny/roselia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(316,\"Gulpin\", \"assets/regular/gulpin.png\", \"assets/shiny/gulpin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(317,\"Swalot\", \"assets/regular/swalot.png\", \"assets/shiny/swalot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(318,\"Carvanha\", \"assets/regular/carvanha.png\", \"assets/shiny/carvanha.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(319,\"Sharpedo\", \"assets/regular/sharpedo.png\", \"assets/shiny/sharpedo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(320,\"Wailmer\", \"assets/regular/wailmer.png\", \"assets/shiny/wailmer.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(321,\"Wailord\", \"assets/regular/wailord.png\", \"assets/shiny/wailord.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(322,\"Numel\", \"assets/regular/numel.png\", \"assets/shiny/numel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(323,\"Camerupt\", \"assets/regular/camerupt.png\", \"assets/shiny/camerupt.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(324,\"Torkoal\", \"assets/regular/torkoal.png\", \"assets/shiny/torkoal.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(325,\"Spoink\", \"assets/regular/spoink.png\", \"assets/shiny/spoink.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(326,\"Grumpig\", \"assets/regular/grumpig.png\", \"assets/shiny/grumpig.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(327,\"Spinda\", \"assets/regular/spinda.png\", \"assets/shiny/spinda.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(328,\"Trapinch\", \"assets/regular/trapinch.png\", \"assets/shiny/trapinch.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(329,\"Vibrava\", \"assets/regular/vibrava.png\", \"assets/shiny/vibrava.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(330,\"Flygon\", \"assets/regular/flygon.png\", \"assets/shiny/flygon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(331,\"Cacnea\", \"assets/regular/cacnea.png\", \"assets/shiny/cacnea.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(332,\"Cacturne\", \"assets/regular/cacturne.png\", \"assets/shiny/cacturne.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(333,\"Swablu\", \"assets/regular/swablu.png\", \"assets/shiny/swablu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(334,\"Altaria\", \"assets/regular/altaria.png\", \"assets/shiny/altaria.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(335,\"Zangoose\", \"assets/regular/zangoose.png\", \"assets/shiny/zangoose.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(336,\"Seviper\", \"assets/regular/seviper.png\", \"assets/shiny/seviper.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(337,\"Lunatone\", \"assets/regular/lunatone.png\", \"assets/shiny/lunatone.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(338,\"Solrock\", \"assets/regular/solrock.png\", \"assets/shiny/solrock.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(339,\"Barboach\", \"assets/regular/barboach.png\", \"assets/shiny/barboach.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(340,\"Whiscash\", \"assets/regular/whiscash.png\", \"assets/shiny/whiscash.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(341,\"Corphish\", \"assets/regular/corphish.png\", \"assets/shiny/corphish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(342,\"Crawdaunt\", \"assets/regular/crawdaunt.png\", \"assets/shiny/crawdaunt.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(343,\"Baltoy\", \"assets/regular/baltoy.png\", \"assets/shiny/baltoy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(344,\"Claydol\", \"assets/regular/claydol.png\", \"assets/shiny/claydol.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(345,\"Lileep\", \"assets/regular/lileep.png\", \"assets/shiny/lileep.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(346,\"Cradily\", \"assets/regular/cradily.png\", \"assets/shiny/cradily.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(347,\"Anorith\", \"assets/regular/anorith.png\", \"assets/shiny/anorith.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(348,\"Armaldo\", \"assets/regular/armaldo.png\", \"assets/shiny/armaldo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(349,\"Feebas\", \"assets/regular/feebas.png\", \"assets/shiny/feebas.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(350,\"Milotic\", \"assets/regular/milotic.png\", \"assets/shiny/milotic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(351,\"Castform\", \"assets/regular/castform.png\", \"assets/shiny/castform.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(352,\"Kecleon\", \"assets/regular/kecleon.png\", \"assets/shiny/kecleon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(353,\"Shuppet\", \"assets/regular/shuppet.png\", \"assets/shiny/shuppet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(354,\"Banette\", \"assets/regular/banette.png\", \"assets/shiny/banette.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(355,\"Duskull\", \"assets/regular/duskull.png\", \"assets/shiny/duskull.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(356,\"Dusclops\", \"assets/regular/dusclops.png\", \"assets/shiny/dusclops.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(357,\"Tropius\", \"assets/regular/tropius.png\", \"assets/shiny/tropius.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(358,\"Chimecho\", \"assets/regular/chimecho.png\", \"assets/shiny/chimecho.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(359,\"Absol\", \"assets/regular/absol.png\", \"assets/shiny/absol.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(360,\"Wynaut\", \"assets/regular/wynaut.png\", \"assets/shiny/wynaut.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(361,\"Snorunt\", \"assets/regular/snorunt.png\", \"assets/shiny/snorunt.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(362,\"Glalie\", \"assets/regular/glalie.png\", \"assets/shiny/glalie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(363,\"Spheal\", \"assets/regular/spheal.png\", \"assets/shiny/spheal.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(364,\"Sealeo\", \"assets/regular/sealeo.png\", \"assets/shiny/sealeo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(365,\"Walrein\", \"assets/regular/walrein.png\", \"assets/shiny/walrein.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(366,\"Clamperl\", \"assets/regular/clamperl.png\", \"assets/shiny/clamperl.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(367,\"Huntail\", \"assets/regular/huntail.png\", \"assets/shiny/huntail.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(368,\"Gorebyss\", \"assets/regular/gorebyss.png\", \"assets/shiny/gorebyss.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(369,\"Relicanth\", \"assets/regular/relicanth.png\", \"assets/shiny/relicanth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(370,\"Luvdisc\", \"assets/regular/luvdisc.png\", \"assets/shiny/luvdisc.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(371,\"Bagon\", \"assets/regular/bagon.png\", \"assets/shiny/bagon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(372,\"Shelgon\", \"assets/regular/shelgon.png\", \"assets/shiny/shelgon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(373,\"Salamence\", \"assets/regular/salamence.png\", \"assets/shiny/salamence.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(374,\"Beldum\", \"assets/regular/beldum.png\", \"assets/shiny/beldum.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(375,\"Metang\", \"assets/regular/metang.png\", \"assets/shiny/metang.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(376,\"Metagross\", \"assets/regular/metagross.png\", \"assets/shiny/metagross.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(377,\"Regirock\", \"assets/regular/regirock.png\", \"assets/shiny/regirock.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(378,\"Regice\", \"assets/regular/regice.png\", \"assets/shiny/regice.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(379,\"Registeel\", \"assets/regular/registeel.png\", \"assets/shiny/registeel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(380,\"Latias\", \"assets/regular/latias.png\", \"assets/shiny/latias.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(381,\"Latios\", \"assets/regular/latios.png\", \"assets/shiny/latios.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(382,\"Kyogre\", \"assets/regular/kyogre.png\", \"assets/shiny/kyogre.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(383,\"Groudon\", \"assets/regular/groudon.png\", \"assets/shiny/groudon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(384,\"Rayquaza\", \"assets/regular/rayquaza.png\", \"assets/shiny/rayquaza.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(385,\"Jirachi\", \"assets/regular/jirachi.png\", \"assets/shiny/jirachi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(386,\"Deoxys\", \"assets/regular/deoxys.png\", \"assets/shiny/deoxys.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(387,\"Turtwig\", \"assets/regular/turtwig.png\", \"assets/shiny/turtwig.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(388,\"Grotle\", \"assets/regular/grotle.png\", \"assets/shiny/grotle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(389,\"Torterra\", \"assets/regular/torterra.png\", \"assets/shiny/torterra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(390,\"Chimchar\", \"assets/regular/chimchar.png\", \"assets/shiny/chimchar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(391,\"Monferno\", \"assets/regular/monferno.png\", \"assets/shiny/monferno.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(392,\"Infernape\", \"assets/regular/infernape.png\", \"assets/shiny/infernape.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(393,\"Piplup\", \"assets/regular/piplup.png\", \"assets/shiny/piplup.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(394,\"Prinplup\", \"assets/regular/prinplup.png\", \"assets/shiny/prinplup.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(395,\"Empoleon\", \"assets/regular/empoleon.png\", \"assets/shiny/empoleon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(396,\"Starly\", \"assets/regular/starly.png\", \"assets/shiny/starly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(397,\"Staravia\", \"assets/regular/staravia.png\", \"assets/shiny/staravia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(398,\"Staraptor\", \"assets/regular/staraptor.png\", \"assets/shiny/staraptor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(399,\"Bidoof\", \"assets/regular/bidoof.png\", \"assets/shiny/bidoof.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(400,\"Bibarel\", \"assets/regular/bibarel.png\", \"assets/shiny/bibarel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(401,\"Kricketot\", \"assets/regular/kricketot.png\", \"assets/shiny/kricketot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(402,\"Kricketune\", \"assets/regular/kricketune.png\", \"assets/shiny/kricketune.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(403,\"Shinx\", \"assets/regular/shinx.png\", \"assets/shiny/shinx.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(404,\"Luxio\", \"assets/regular/luxio.png\", \"assets/shiny/luxio.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(405,\"Luxray\", \"assets/regular/luxray.png\", \"assets/shiny/luxray.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(406,\"Budew\", \"assets/regular/budew.png\", \"assets/shiny/budew.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(407,\"Roserade\", \"assets/regular/roserade.png\", \"assets/shiny/roserade.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(408,\"Cranidos\", \"assets/regular/cranidos.png\", \"assets/shiny/cranidos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(409,\"Rampardos\", \"assets/regular/rampardos.png\", \"assets/shiny/rampardos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(410,\"Shieldon\", \"assets/regular/shieldon.png\", \"assets/shiny/shieldon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(411,\"Bastiodon\", \"assets/regular/bastiodon.png\", \"assets/shiny/bastiodon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(412,\"Burmy\", \"assets/regular/burmy.png\", \"assets/shiny/burmy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(413,\"Wormadam\", \"assets/regular/wormadam.png\", \"assets/shiny/wormadam.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(414,\"Mothim\", \"assets/regular/mothim.png\", \"assets/shiny/mothim.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(415,\"Combee\", \"assets/regular/combee.png\", \"assets/shiny/combee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(416,\"Vespiquen\", \"assets/regular/vespiquen.png\", \"assets/shiny/vespiquen.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(417,\"Pachirisu\", \"assets/regular/pachirisu.png\", \"assets/shiny/pachirisu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(418,\"Buizel\", \"assets/regular/buizel.png\", \"assets/shiny/buizel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(419,\"Floatzel\", \"assets/regular/floatzel.png\", \"assets/shiny/floatzel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(420,\"Cherubi\", \"assets/regular/cherubi.png\", \"assets/shiny/cherubi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(421,\"Cherrim\", \"assets/regular/cherrim.png\", \"assets/shiny/cherrim.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(422,\"Shellos\", \"assets/regular/shellos.png\", \"assets/shiny/shellos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(423,\"Gastrodon\", \"assets/regular/gastrodon.png\", \"assets/shiny/gastrodon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(424,\"Ambipom\", \"assets/regular/ambipom.png\", \"assets/shiny/ambipom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(425,\"Drifloon\", \"assets/regular/drifloon.png\", \"assets/shiny/drifloon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(426,\"Drifblim\", \"assets/regular/drifblim.png\", \"assets/shiny/drifblim.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(427,\"Buneary\", \"assets/regular/buneary.png\", \"assets/shiny/buneary.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(428,\"Lopunny\", \"assets/regular/lopunny.png\", \"assets/shiny/lopunny.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(429,\"Mismagius\", \"assets/regular/mismagius.png\", \"assets/shiny/mismagius.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(430,\"Honchkrow\", \"assets/regular/honchkrow.png\", \"assets/shiny/honchkrow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(431,\"Glameow\", \"assets/regular/glameow.png\", \"assets/shiny/glameow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(432,\"Purugly\", \"assets/regular/purugly.png\", \"assets/shiny/purugly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(433,\"Chingling\", \"assets/regular/chingling.png\", \"assets/shiny/chingling.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(434,\"Stunky\", \"assets/regular/stunky.png\", \"assets/shiny/stunky.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(435,\"Skuntank\", \"assets/regular/skuntank.png\", \"assets/shiny/skuntank.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(436,\"Bronzor\", \"assets/regular/bronzor.png\", \"assets/shiny/bronzor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(437,\"Bronzong\", \"assets/regular/bronzong.png\", \"assets/shiny/bronzong.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(438,\"Bonsly\", \"assets/regular/bonsly.png\", \"assets/shiny/bonsly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(439,\"Mime.jr\", \"assets/regular/mime-jr.png\", \"assets/shiny/mime-jr.png\" )");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(440,\"Happiny\", \"assets/regular/happiny.png\", \"assets/shiny/happiny.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(441,\"Chatot\", \"assets/regular/chatot.png\", \"assets/shiny/chatot.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(442,\"Spiritomb\", \"assets/regular/spiritomb.png\", \"assets/shiny/spiritomb.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(443,\"Gible\", \"assets/regular/gible.png\", \"assets/shiny/gible.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(444,\"Gabite\", \"assets/regular/gabite.png\", \"assets/shiny/gabite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(445,\"Garchomp\", \"assets/regular/garchomp.png\", \"assets/shiny/garchomp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(446,\"Munchlax\", \"assets/regular/munchlax.png\", \"assets/shiny/munchlax.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(447,\"Riolu\", \"assets/regular/riolu.png\", \"assets/shiny/riolu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(448,\"Lucario\", \"assets/regular/lucario.png\", \"assets/shiny/lucario.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(449,\"Hippopotas\", \"assets/regular/hippopotas.png\", \"assets/shiny/hippopotas.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(450,\"Hippowdon\", \"assets/regular/hippowdon.png\", \"assets/shiny/hippowdon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(451,\"Skorupi\", \"assets/regular/skorupi.png\", \"assets/shiny/skorupi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(452,\"Drapion\", \"assets/regular/drapion.png\", \"assets/shiny/drapion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(453,\"Croagunk\", \"assets/regular/croagunk.png\", \"assets/shiny/croagunk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(454,\"Toxicroak\", \"assets/regular/toxicroak.png\", \"assets/shiny/toxicroak.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(455,\"Carnivine\", \"assets/regular/carnivine.png\", \"assets/shiny/carnivine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(456,\"Finneon\", \"assets/regular/finneon.png\", \"assets/shiny/finneon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(457,\"Lumineon\", \"assets/regular/lumineon.png\", \"assets/shiny/lumineon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(458,\"Mantyke\", \"assets/regular/mantyke.png\", \"assets/shiny/mantyke.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(459,\"Snover\", \"assets/regular/snover.png\", \"assets/shiny/snover.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(460,\"Abomasnow\", \"assets/regular/abomasnow.png\", \"assets/shiny/abomasnow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(461,\"Weavile\", \"assets/regular/weavile.png\", \"assets/shiny/weavile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(462,\"Magnezone\", \"assets/regular/magnezone.png\", \"assets/shiny/magnezone.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(463,\"Lickilicky\", \"assets/regular/lickilicky.png\", \"assets/shiny/lickilicky.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(464,\"Rhyperior\", \"assets/regular/rhyperior.png\", \"assets/shiny/rhyperior.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(465,\"Tangrowth\", \"assets/regular/tangrowth.png\", \"assets/shiny/tangrowth.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(466,\"Electivire\", \"assets/regular/electivire.png\", \"assets/shiny/electivire.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(467,\"Magmortar\", \"assets/regular/magmortar.png\", \"assets/shiny/magmortar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(468,\"Togekiss\", \"assets/regular/togekiss.png\", \"assets/shiny/togekiss.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(469,\"Yanmega\", \"assets/regular/yanmega.png\", \"assets/shiny/yanmega.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(470,\"Leafeon\", \"assets/regular/leafeon.png\", \"assets/shiny/leafeon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(471,\"Glaceon\", \"assets/regular/glaceon.png\", \"assets/shiny/glaceon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(472,\"Gliscor\", \"assets/regular/gliscor.png\", \"assets/shiny/gliscor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(473,\"Mamoswine\", \"assets/regular/mamoswine.png\", \"assets/shiny/mamoswine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(474,\"Porygo\", \"assets/regular/porygo.png\", \"assets/shiny/porygo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(475,\"Gallade\", \"assets/regular/gallade.png\", \"assets/shiny/gallade.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(476,\"Probopass\", \"assets/regular/probopass.png\", \"assets/shiny/probopass.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(477,\"Dusknoir\", \"assets/regular/dusknoir.png\", \"assets/shiny/dusknoir.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(478,\"Froslass\", \"assets/regular/froslass.png\", \"assets/shiny/froslass.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(479,\"Rotom\", \"assets/regular/rotom.png\", \"assets/shiny/rotom.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(480,\"Uxie\", \"assets/regular/uxie.png\", \"assets/shiny/uxie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(481,\"Mesprit\", \"assets/regular/mesprit.png\", \"assets/shiny/mesprit.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(482,\"Azelf\", \"assets/regular/azelf.png\", \"assets/shiny/azelf.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(483,\"Dialga\", \"assets/regular/dialga.png\", \"assets/shiny/dialga.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(484,\"Palkia\", \"assets/regular/palkia.png\", \"assets/shiny/palkia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(485,\"Heatran\", \"assets/regular/heatran.png\", \"assets/shiny/heatran.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(486,\"Regigigas\", \"assets/regular/regigigas.png\", \"assets/shiny/regigigas.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(487,\"Giratina\", \"assets/regular/giratina.png\", \"assets/shiny/giratina.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(488,\"Cresselia\", \"assets/regular/cresselia.png\", \"assets/shiny/cresselia.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(489,\"Phione\", \"assets/regular/phione.png\", \"assets/shiny/phione.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(490,\"Manaphy\", \"assets/regular/manaphy.png\", \"assets/shiny/manaphy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(491,\"Darkrai\", \"assets/regular/darkrai.png\", \"assets/shiny/darkrai.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(492,\"Shaymin\", \"assets/regular/shaymin.png\", \"assets/shiny/shaymin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(493,\"Arceus\", \"assets/regular/arceus.png\", \"assets/shiny/arceus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(494,\"Victini\", \"assets/regular/victini.png\", \"assets/shiny/victini.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(495,\"Snivy\", \"assets/regular/snivy.png\", \"assets/shiny/snivy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(496,\"Servine\", \"assets/regular/servine.png\", \"assets/shiny/servine.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(497,\"Serperior\", \"assets/regular/serperior.png\", \"assets/shiny/serperior.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(498,\"Tepig\", \"assets/regular/tepig.png\", \"assets/shiny/tepig.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(499,\"Pignite\", \"assets/regular/pignite.png\", \"assets/shiny/pignite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(500,\"Emboar\", \"assets/regular/emboar.png\", \"assets/shiny/emboar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(501,\"Oshawott\", \"assets/regular/oshawott.png\", \"assets/shiny/oshawott.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(502,\"Dewott\", \"assets/regular/dewott.png\", \"assets/shiny/dewott.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(503,\"Samurott\", \"assets/regular/samurott.png\", \"assets/shiny/samurott.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(504,\"Patrat\", \"assets/regular/patrat.png\", \"assets/shiny/patrat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(505,\"Watchog\", \"assets/regular/watchog.png\", \"assets/shiny/watchog.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(506,\"Lillipup\", \"assets/regular/lillipup.png\", \"assets/shiny/lillipup.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(507,\"Herdier\", \"assets/regular/herdier.png\", \"assets/shiny/herdier.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(508,\"Stoutland\", \"assets/regular/stoutland.png\", \"assets/shiny/stoutland.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(509,\"Purrloin\", \"assets/regular/purrloin.png\", \"assets/shiny/purrloin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(510,\"Liepard\", \"assets/regular/liepard.png\", \"assets/shiny/liepard.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(511,\"Pansage\", \"assets/regular/pansage.png\", \"assets/shiny/pansage.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(512,\"Simisage\", \"assets/regular/simisage.png\", \"assets/shiny/simisage.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(513,\"Pansear\", \"assets/regular/pansear.png\", \"assets/shiny/pansear.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(514,\"Simisear\", \"assets/regular/simisear.png\", \"assets/shiny/simisear.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(515,\"Panpour\", \"assets/regular/panpour.png\", \"assets/shiny/panpour.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(516,\"Simipour\", \"assets/regular/simipour.png\", \"assets/shiny/simipour.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(517,\"Munna\", \"assets/regular/munna.png\", \"assets/shiny/munna.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(518,\"Musharna\", \"assets/regular/musharna.png\", \"assets/shiny/musharna.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(519,\"Pidove\", \"assets/regular/pidove.png\", \"assets/shiny/pidove.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(520,\"Tranquill\", \"assets/regular/tranquill.png\", \"assets/shiny/tranquill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(521,\"Unfezant\", \"assets/regular/unfezant.png\", \"assets/shiny/unfezant.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(522,\"Blitzle\", \"assets/regular/blitzle.png\", \"assets/shiny/blitzle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(523,\"Zebstrika\", \"assets/regular/zebstrika.png\", \"assets/shiny/zebstrika.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(524,\"Roggenrola\", \"assets/regular/roggenrola.png\", \"assets/shiny/roggenrola.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(525,\"Boldore\", \"assets/regular/boldore.png\", \"assets/shiny/boldore.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(526,\"Gigalith\", \"assets/regular/gigalith.png\", \"assets/shiny/gigalith.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(527,\"Woobat\", \"assets/regular/woobat.png\", \"assets/shiny/woobat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(528,\"Swoobat\", \"assets/regular/swoobat.png\", \"assets/shiny/swoobat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(529,\"Drilbur\", \"assets/regular/drilbur.png\", \"assets/shiny/drilbur.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(530,\"Excadrill\", \"assets/regular/excadrill.png\", \"assets/shiny/excadrill.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(531,\"Audino\", \"assets/regular/audino.png\", \"assets/shiny/audino.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(532,\"Timburr\", \"assets/regular/timburr.png\", \"assets/shiny/timburr.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(533,\"Gurdurr\", \"assets/regular/gurdurr.png\", \"assets/shiny/gurdurr.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(534,\"Conkeldurr\", \"assets/regular/conkeldurr.png\", \"assets/shiny/conkeldurr.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(535,\"Tympole\", \"assets/regular/tympole.png\", \"assets/shiny/tympole.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(536,\"Palpitoad\", \"assets/regular/palpitoad.png\", \"assets/shiny/palpitoad.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(537,\"Seismitoad\", \"assets/regular/seismitoad.png\", \"assets/shiny/seismitoad.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(538,\"Throh\", \"assets/regular/throh.png\", \"assets/shiny/throh.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(539,\"Sawk\", \"assets/regular/sawk.png\", \"assets/shiny/sawk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(540,\"Sewaddle\", \"assets/regular/sewaddle.png\", \"assets/shiny/sewaddle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(541,\"Swadloon\", \"assets/regular/swadloon.png\", \"assets/shiny/swadloon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(542,\"Leavanny\", \"assets/regular/leavanny.png\", \"assets/shiny/leavanny.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(543,\"Venipede\", \"assets/regular/venipede.png\", \"assets/shiny/venipede.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(544,\"Whirlipede\", \"assets/regular/whirlipede.png\", \"assets/shiny/whirlipede.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(545,\"Scolipede\", \"assets/regular/scolipede.png\", \"assets/shiny/scolipede.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(546,\"Cottonee\", \"assets/regular/cottonee.png\", \"assets/shiny/cottonee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(547,\"Whimsicott\", \"assets/regular/whimsicott.png\", \"assets/shiny/whimsicott.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(548,\"Petilil\", \"assets/regular/petilil.png\", \"assets/shiny/petilil.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(549,\"Lilligant\", \"assets/regular/lilligant.png\", \"assets/shiny/lilligant.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(550,\"Basculin\", \"assets/regular/basculin.png\", \"assets/shiny/basculin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(551,\"Sandile\", \"assets/regular/sandile.png\", \"assets/shiny/sandile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(552,\"Krokorok\", \"assets/regular/krokorok.png\", \"assets/shiny/krokorok.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(553,\"Krookodile\", \"assets/regular/krookodile.png\", \"assets/shiny/krookodile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(554,\"Darumaka\", \"assets/regular/darumaka.png\", \"assets/shiny/darumaka.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(555,\"Darmanitan\", \"assets/regular/darmanitan.png\", \"assets/shiny/darmanitan.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(556,\"Maractus\", \"assets/regular/maractus.png\", \"assets/shiny/maractus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(557,\"Dwebble\", \"assets/regular/dwebble.png\", \"assets/shiny/dwebble.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(558,\"Crustle\", \"assets/regular/crustle.png\", \"assets/shiny/crustle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(559,\"Scraggy\", \"assets/regular/scraggy.png\", \"assets/shiny/scraggy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(560,\"Scrafty\", \"assets/regular/scrafty.png\", \"assets/shiny/scrafty.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(561,\"Sigilyph\", \"assets/regular/sigilyph.png\", \"assets/shiny/sigilyph.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(562,\"Yamask\", \"assets/regular/yamask.png\", \"assets/shiny/yamask.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(563,\"Cofagrigus\", \"assets/regular/cofagrigus.png\", \"assets/shiny/cofagrigus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(564,\"Tirtouga\", \"assets/regular/tirtouga.png\", \"assets/shiny/tirtouga.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(565,\"Carracosta\", \"assets/regular/carracosta.png\", \"assets/shiny/carracosta.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(566,\"Archen\", \"assets/regular/archen.png\", \"assets/shiny/archen.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(567,\"Archeops\", \"assets/regular/archeops.png\", \"assets/shiny/archeops.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(568,\"Trubbish\", \"assets/regular/trubbish.png\", \"assets/shiny/trubbish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(569,\"Garbodor\", \"assets/regular/garbodor.png\", \"assets/shiny/garbodor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(570,\"Zorua\", \"assets/regular/zorua.png\", \"assets/shiny/zorua.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(571,\"Zoroark\", \"assets/regular/zoroark.png\", \"assets/shiny/zoroark.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(572,\"Minccino\", \"assets/regular/minccino.png\", \"assets/shiny/minccino.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(573,\"Cinccino\", \"assets/regular/cinccino.png\", \"assets/shiny/cinccino.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(574,\"Gothita\", \"assets/regular/gothita.png\", \"assets/shiny/gothita.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(575,\"Gothorita\", \"assets/regular/gothorita.png\", \"assets/shiny/gothorita.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(576,\"Gothitelle\", \"assets/regular/gothitelle.png\", \"assets/shiny/gothitelle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(577,\"Solosis\", \"assets/regular/solosis.png\", \"assets/shiny/solosis.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(578,\"Duosion\", \"assets/regular/duosion.png\", \"assets/shiny/duosion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(579,\"Reuniclus\", \"assets/regular/reuniclus.png\", \"assets/shiny/reuniclus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(580,\"Ducklett\", \"assets/regular/ducklett.png\", \"assets/shiny/ducklett.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(581,\"Swanna\", \"assets/regular/swanna.png\", \"assets/shiny/swanna.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(582,\"Vanillite\", \"assets/regular/vanillite.png\", \"assets/shiny/vanillite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(583,\"Vanillish\", \"assets/regular/vanillish.png\", \"assets/shiny/vanillish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(584,\"Vanilluxe\", \"assets/regular/vanilluxe.png\", \"assets/shiny/vanilluxe.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(585,\"Deerling\", \"assets/regular/deerling.png\", \"assets/shiny/deerling.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(586,\"Sawsbuck\", \"assets/regular/sawsbuck.png\", \"assets/shiny/sawsbuck.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(587,\"Emolga\", \"assets/regular/emolga.png\", \"assets/shiny/emolga.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(588,\"Karrablast\", \"assets/regular/karrablast.png\", \"assets/shiny/karrablast.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(589,\"Escavalier\", \"assets/regular/escavalier.png\", \"assets/shiny/escavalier.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(590,\"Foongus\", \"assets/regular/foongus.png\", \"assets/shiny/foongus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(591,\"Amoonguss\", \"assets/regular/amoonguss.png\", \"assets/shiny/amoonguss.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(592,\"Frillish\", \"assets/regular/frillish.png\", \"assets/shiny/frillish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(593,\"Jellicent\", \"assets/regular/jellicent.png\", \"assets/shiny/jellicent.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(594,\"Alomomola\", \"assets/regular/alomomola.png\", \"assets/shiny/alomomola.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(595,\"Joltik\", \"assets/regular/joltik.png\", \"assets/shiny/joltik.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(596,\"Galvantula\", \"assets/regular/galvantula.png\", \"assets/shiny/galvantula.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(597,\"Ferroseed\", \"assets/regular/ferroseed.png\", \"assets/shiny/ferroseed.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(598,\"Ferrothorn\", \"assets/regular/ferrothorn.png\", \"assets/shiny/ferrothorn.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(599,\"Klink\", \"assets/regular/klink.png\", \"assets/shiny/klink.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(600,\"Klang\", \"assets/regular/klang.png\", \"assets/shiny/klang.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(601,\"Klinklang\", \"assets/regular/klinklang.png\", \"assets/shiny/klinklang.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(602,\"Tynamo\", \"assets/regular/tynamo.png\", \"assets/shiny/tynamo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(603,\"Eelektrik\", \"assets/regular/eelektrik.png\", \"assets/shiny/eelektrik.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(604,\"Eelektross\", \"assets/regular/eelektross.png\", \"assets/shiny/eelektross.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(605,\"Elgyem\", \"assets/regular/elgyem.png\", \"assets/shiny/elgyem.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(606,\"Beheeyem\", \"assets/regular/beheeyem.png\", \"assets/shiny/beheeyem.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(607,\"Litwick\", \"assets/regular/litwick.png\", \"assets/shiny/litwick.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(608,\"Lampent\", \"assets/regular/lampent.png\", \"assets/shiny/lampent.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(609,\"Chandelure\", \"assets/regular/chandelure.png\", \"assets/shiny/chandelure.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(610,\"Axew\", \"assets/regular/axew.png\", \"assets/shiny/axew.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(611,\"Fraxure\", \"assets/regular/fraxure.png\", \"assets/shiny/fraxure.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(612,\"Haxorus\", \"assets/regular/haxorus.png\", \"assets/shiny/haxorus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(613,\"Cubchoo\", \"assets/regular/cubchoo.png\", \"assets/shiny/cubchoo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(614,\"Beartic\", \"assets/regular/beartic.png\", \"assets/shiny/beartic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(615,\"Cryogonal\", \"assets/regular/cryogonal.png\", \"assets/shiny/cryogonal.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(616,\"Shelmet\", \"assets/regular/shelmet.png\", \"assets/shiny/shelmet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(617,\"Accelgor\", \"assets/regular/accelgor.png\", \"assets/shiny/accelgor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(618,\"Stunfisk\", \"assets/regular/stunfisk.png\", \"assets/shiny/stunfisk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(619,\"Mienfoo\", \"assets/regular/mienfoo.png\", \"assets/shiny/mienfoo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(620,\"Mienshao\", \"assets/regular/mienshao.png\", \"assets/shiny/mienshao.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(621,\"Druddigon\", \"assets/regular/druddigon.png\", \"assets/shiny/druddigon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(622,\"Golett\", \"assets/regular/golett.png\", \"assets/shiny/golett.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(623,\"Golurk\", \"assets/regular/golurk.png\", \"assets/shiny/golurk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(624,\"Pawniard\", \"assets/regular/pawniard.png\", \"assets/shiny/pawniard.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(625,\"Bisharp\", \"assets/regular/bisharp.png\", \"assets/shiny/bisharp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(626,\"Bouffalant\", \"assets/regular/bouffalant.png\", \"assets/shiny/bouffalant.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(627,\"Rufflet\", \"assets/regular/rufflet.png\", \"assets/shiny/rufflet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(628,\"Braviary\", \"assets/regular/braviary.png\", \"assets/shiny/braviary.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(629,\"Vullaby\", \"assets/regular/vullaby.png\", \"assets/shiny/vullaby.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(630,\"Mandibuzz\", \"assets/regular/mandibuzz.png\", \"assets/shiny/mandibuzz.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(631,\"Heatmor\", \"assets/regular/heatmor.png\", \"assets/shiny/heatmor.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(632,\"Durant\", \"assets/regular/durant.png\", \"assets/shiny/durant.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(633,\"Deino\", \"assets/regular/deino.png\", \"assets/shiny/deino.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(634,\"Zweilous\", \"assets/regular/zweilous.png\", \"assets/shiny/zweilous.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(635,\"Hydreigon\", \"assets/regular/hydreigon.png\", \"assets/shiny/hydreigon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(636,\"Larvesta\", \"assets/regular/larvesta.png\", \"assets/shiny/larvesta.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(637,\"Volcarona\", \"assets/regular/volcarona.png\", \"assets/shiny/volcarona.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(638,\"Cobalion\", \"assets/regular/cobalion.png\", \"assets/shiny/cobalion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(639,\"Terrakion\", \"assets/regular/terrakion.png\", \"assets/shiny/terrakion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(640,\"Virizion\", \"assets/regular/virizion.png\", \"assets/shiny/virizion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(641,\"Tornadus\", \"assets/regular/tornadus.png\", \"assets/shiny/tornadus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(642,\"Thundurus\", \"assets/regular/thundurus.png\", \"assets/shiny/thundurus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(643,\"Reshiram\", \"assets/regular/reshiram.png\", \"assets/shiny/reshiram.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(644,\"Zekrom \", \"assets/regular/zekrom .png\", \"assets/shiny/zekrom .png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(645,\"Landorus\", \"assets/regular/landorus.png\", \"assets/shiny/landorus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(646,\"Kyurem\", \"assets/regular/kyurem.png\", \"assets/shiny/kyurem.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(647,\"Keldeo\", \"assets/regular/keldeo.png\", \"assets/shiny/keldeo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(648,\"Meloetta\", \"assets/regular/meloetta.png\", \"assets/shiny/meloetta.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(649,\"Genesect\", \"assets/regular/genesect.png\", \"assets/shiny/genesect.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(650,\"Chespin\", \"assets/regular/chespin.png\", \"assets/shiny/chespin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(651,\"Quilladin\", \"assets/regular/quilladin.png\", \"assets/shiny/quilladin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(652,\"Chesnaught\", \"assets/regular/chesnaught.png\", \"assets/shiny/chesnaught.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(653,\"Fennekin\", \"assets/regular/fennekin.png\", \"assets/shiny/fennekin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(654,\"Braixen\", \"assets/regular/braixen.png\", \"assets/shiny/braixen.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(655,\"Delphox\", \"assets/regular/delphox.png\", \"assets/shiny/delphox.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(656,\"Froakie\", \"assets/regular/froakie.png\", \"assets/shiny/froakie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(657,\"Frogadier\", \"assets/regular/frogadier.png\", \"assets/shiny/frogadier.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(658,\"Greninja\", \"assets/regular/greninja.png\", \"assets/shiny/greninja.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(659,\"Bunnelby\", \"assets/regular/bunnelby.png\", \"assets/shiny/bunnelby.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(660,\"Diggersby\", \"assets/regular/diggersby.png\", \"assets/shiny/diggersby.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(661,\"Fletchling\", \"assets/regular/fletchling.png\", \"assets/shiny/fletchling.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(662,\"Fletchinder\", \"assets/regular/fletchinder.png\", \"assets/shiny/fletchinder.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(663,\"Talonflame\", \"assets/regular/talonflame.png\", \"assets/shiny/talonflame.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(664,\"Scatterbug\", \"assets/regular/scatterbug.png\", \"assets/shiny/scatterbug.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(665,\"Spewpa\", \"assets/regular/spewpa.png\", \"assets/shiny/spewpa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(666,\"Vivillon\", \"assets/regular/vivillon.png\", \"assets/shiny/vivillon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(667,\"Litleo\", \"assets/regular/litleo.png\", \"assets/shiny/litleo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(668,\"Pyroar\", \"assets/regular/pyroar.png\", \"assets/shiny/pyroar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(669,\"Flabébé\", \"assets/regular/flabébé.png\", \"assets/shiny/flabébé.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(670,\"Floette\", \"assets/regular/floette.png\", \"assets/shiny/floette.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(671,\"Florges\", \"assets/regular/florges.png\", \"assets/shiny/florges.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(672,\"Skiddo\", \"assets/regular/skiddo.png\", \"assets/shiny/skiddo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(673,\"Gogoat\", \"assets/regular/gogoat.png\", \"assets/shiny/gogoat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(674,\"Pancham\", \"assets/regular/pancham.png\", \"assets/shiny/pancham.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(675,\"Pangoro\", \"assets/regular/pangoro.png\", \"assets/shiny/pangoro.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(676,\"Furfrou\", \"assets/regular/furfrou.png\", \"assets/shiny/furfrou.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(677,\"Espurr\", \"assets/regular/espurr.png\", \"assets/shiny/espurr.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(678,\"Meowstic\", \"assets/regular/meowstic.png\", \"assets/shiny/meowstic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(679,\"Honedge\", \"assets/regular/honedge.png\", \"assets/shiny/honedge.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(680,\"Doublade\", \"assets/regular/doublade.png\", \"assets/shiny/doublade.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(681,\"Aegislash\", \"assets/regular/aegislash.png\", \"assets/shiny/aegislash.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(682,\"Spritzee\", \"assets/regular/spritzee.png\", \"assets/shiny/spritzee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(683,\"Aromatisse\", \"assets/regular/aromatisse.png\", \"assets/shiny/aromatisse.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(684,\"Swirlix\", \"assets/regular/swirlix.png\", \"assets/shiny/swirlix.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(685,\"Slurpuff\", \"assets/regular/slurpuff.png\", \"assets/shiny/slurpuff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(686,\"Inkay\", \"assets/regular/inkay.png\", \"assets/shiny/inkay.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(687,\"Malamar\", \"assets/regular/malamar.png\", \"assets/shiny/malamar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(688,\"Binacle\", \"assets/regular/binacle.png\", \"assets/shiny/binacle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(689,\"Barbaracle\", \"assets/regular/barbaracle.png\", \"assets/shiny/barbaracle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(690,\"Skrelp\", \"assets/regular/skrelp.png\", \"assets/shiny/skrelp.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(691,\"Dragalge\", \"assets/regular/dragalge.png\", \"assets/shiny/dragalge.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(692,\"Clauncher\", \"assets/regular/clauncher.png\", \"assets/shiny/clauncher.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(693,\"Clawitzer\", \"assets/regular/clawitzer.png\", \"assets/shiny/clawitzer.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(694,\"Helioptile\", \"assets/regular/helioptile.png\", \"assets/shiny/helioptile.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(695,\"Heliolisk\", \"assets/regular/heliolisk.png\", \"assets/shiny/heliolisk.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(696,\"Tyrunt\", \"assets/regular/tyrunt.png\", \"assets/shiny/tyrunt.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(697,\"Tyrantrum\", \"assets/regular/tyrantrum.png\", \"assets/shiny/tyrantrum.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(698,\"Amaura\", \"assets/regular/amaura.png\", \"assets/shiny/amaura.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(699,\"Aurorus\", \"assets/regular/aurorus.png\", \"assets/shiny/aurorus.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(700,\"Sylveon\", \"assets/regular/sylveon.png\", \"assets/shiny/sylveon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(701,\"Hawlucha\", \"assets/regular/hawlucha.png\", \"assets/shiny/hawlucha.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(702,\"Dedenne\", \"assets/regular/dedenne.png\", \"assets/shiny/dedenne.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(703,\"Carbink\", \"assets/regular/carbink.png\", \"assets/shiny/carbink.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(704,\"Goomy\", \"assets/regular/goomy.png\", \"assets/shiny/goomy.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(705,\"Sliggoo\", \"assets/regular/sliggoo.png\", \"assets/shiny/sliggoo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(706,\"Goodra\", \"assets/regular/goodra.png\", \"assets/shiny/goodra.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(707,\"Klefki\", \"assets/regular/klefki.png\", \"assets/shiny/klefki.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(708,\"Phantump\", \"assets/regular/phantump.png\", \"assets/shiny/phantump.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(709,\"Trevenant\", \"assets/regular/trevenant.png\", \"assets/shiny/trevenant.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(710,\"Pumpkaboo\", \"assets/regular/pumpkaboo.png\", \"assets/shiny/pumpkaboo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(711,\"Gourgeist\", \"assets/regular/gourgeist.png\", \"assets/shiny/gourgeist.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(712,\"Bergmite\", \"assets/regular/bergmite.png\", \"assets/shiny/bergmite.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(713,\"Avalugg\", \"assets/regular/avalugg.png\", \"assets/shiny/avalugg.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(714,\"Noibat\", \"assets/regular/noibat.png\", \"assets/shiny/noibat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(715,\"Noivern\", \"assets/regular/noivern.png\", \"assets/shiny/noivern.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(716,\"Xerneas\", \"assets/regular/xerneas.png\", \"assets/shiny/xerneas.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(717,\"Yveltal\", \"assets/regular/yveltal.png\", \"assets/shiny/yveltal.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(718,\"Zygarde\", \"assets/regular/zygarde.png\", \"assets/shiny/zygarde.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(719,\"Diancie\", \"assets/regular/diancie.png\", \"assets/shiny/diancie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(720,\"Hoopa\", \"assets/regular/hoopa.png\", \"assets/shiny/hoopa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(721,\"Volcanion\", \"assets/regular/volcanion.png\", \"assets/shiny/volcanion.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(722,\"Rowlet\", \"assets/regular/rowlet.png\", \"assets/shiny/rowlet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(723,\"Dartrix\", \"assets/regular/dartrix.png\", \"assets/shiny/dartrix.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(724,\"Decidueye\", \"assets/regular/decidueye.png\", \"assets/shiny/decidueye.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(725,\"Litten\", \"assets/regular/litten.png\", \"assets/shiny/litten.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(726,\"Torracat\", \"assets/regular/torracat.png\", \"assets/shiny/torracat.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(727,\"Incineroar\", \"assets/regular/incineroar.png\", \"assets/shiny/incineroar.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(728,\"Popplio\", \"assets/regular/popplio.png\", \"assets/shiny/popplio.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(729,\"Brionne\", \"assets/regular/brionne.png\", \"assets/shiny/brionne.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(730,\"Primarina\", \"assets/regular/primarina.png\", \"assets/shiny/primarina.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(731,\"Pikipek\", \"assets/regular/pikipek.png\", \"assets/shiny/pikipek.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(732,\"Trumbeak\", \"assets/regular/trumbeak.png\", \"assets/shiny/trumbeak.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(733,\"Toucannon\", \"assets/regular/toucannon.png\", \"assets/shiny/toucannon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(734,\"Yungoos\", \"assets/regular/yungoos.png\", \"assets/shiny/yungoos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(735,\"Gumshoos\", \"assets/regular/gumshoos.png\", \"assets/shiny/gumshoos.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(736,\"Grubbin\", \"assets/regular/grubbin.png\", \"assets/shiny/grubbin.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(737,\"Charjabug\", \"assets/regular/charjabug.png\", \"assets/shiny/charjabug.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(738,\"Vikavolt\", \"assets/regular/vikavolt.png\", \"assets/shiny/vikavolt.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(739,\"Crabrawler\", \"assets/regular/crabrawler.png\", \"assets/shiny/crabrawler.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(740,\"Crabominable\", \"assets/regular/crabominable.png\", \"assets/shiny/crabominable.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(741,\"Oricorio\", \"assets/regular/oricorio.png\", \"assets/shiny/oricorio.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(742,\"Cutiefly\", \"assets/regular/cutiefly.png\", \"assets/shiny/cutiefly.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(743,\"Ribombee\", \"assets/regular/ribombee.png\", \"assets/shiny/ribombee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(744,\"Rockruff\", \"assets/regular/rockruff.png\", \"assets/shiny/rockruff.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(745,\"Lycanroc\", \"assets/regular/lycanroc.png\", \"assets/shiny/lycanroc.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(746,\"Wishiwashi\", \"assets/regular/wishiwashi.png\", \"assets/shiny/wishiwashi.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(747,\"Mareanie\", \"assets/regular/mareanie.png\", \"assets/shiny/mareanie.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(748,\"Toxapex\", \"assets/regular/toxapex.png\", \"assets/shiny/toxapex.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(749,\"Mudbray\", \"assets/regular/mudbray.png\", \"assets/shiny/mudbray.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(750,\"Mudsdale\", \"assets/regular/mudsdale.png\", \"assets/shiny/mudsdale.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(751,\"Dewpider\", \"assets/regular/dewpider.png\", \"assets/shiny/dewpider.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(752,\"Araquanid\", \"assets/regular/araquanid.png\", \"assets/shiny/araquanid.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(753,\"Fomantis\", \"assets/regular/fomantis.png\", \"assets/shiny/fomantis.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(754,\"Lurantis\", \"assets/regular/lurantis.png\", \"assets/shiny/lurantis.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(755,\"Morelull\", \"assets/regular/morelull.png\", \"assets/shiny/morelull.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(756,\"Shiinotic\", \"assets/regular/shiinotic.png\", \"assets/shiny/shiinotic.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(757,\"Salandit\", \"assets/regular/salandit.png\", \"assets/shiny/salandit.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(758,\"Salazzle\", \"assets/regular/salazzle.png\", \"assets/shiny/salazzle.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(759,\"Stufful\", \"assets/regular/stufful.png\", \"assets/shiny/stufful.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(760,\"Bewear\", \"assets/regular/bewear.png\", \"assets/shiny/bewear.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(761,\"Bounsweet\", \"assets/regular/bounsweet.png\", \"assets/shiny/bounsweet.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(762,\"Steenee\", \"assets/regular/steenee.png\", \"assets/shiny/steenee.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(763,\"Tsareena\", \"assets/regular/tsareena.png\", \"assets/shiny/tsareena.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(764,\"Comfey\", \"assets/regular/comfey.png\", \"assets/shiny/comfey.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(765,\"Oranguru\", \"assets/regular/oranguru.png\", \"assets/shiny/oranguru.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(766,\"Passimian\", \"assets/regular/passimian.png\", \"assets/shiny/passimian.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(767,\"Wimpod\", \"assets/regular/wimpod.png\", \"assets/shiny/wimpod.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(768,\"Golisopod\", \"assets/regular/golisopod.png\", \"assets/shiny/golisopod.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(769,\"Sandygast\", \"assets/regular/sandygast.png\", \"assets/shiny/sandygast.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(770,\"Palossand\", \"assets/regular/palossand.png\", \"assets/shiny/palossand.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(771,\"Pyukumuku\", \"assets/regular/pyukumuku.png\", \"assets/shiny/pyukumuku.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(772,\"Type: Null\", \"assets/regular/type: null.png\", \"assets/shiny/type: null.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(773,\"Silvally\", \"assets/regular/silvally.png\", \"assets/shiny/silvally.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(774,\"Minior\", \"assets/regular/minior.png\", \"assets/shiny/minior.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(775,\"Komala\", \"assets/regular/komala.png\", \"assets/shiny/komala.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(776,\"Turtonator\", \"assets/regular/turtonator.png\", \"assets/shiny/turtonator.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(777,\"Togedemaru\", \"assets/regular/togedemaru.png\", \"assets/shiny/togedemaru.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(778,\"Mimikyu\", \"assets/regular/mimikyu.png\", \"assets/shiny/mimikyu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(779,\"Bruxish\", \"assets/regular/bruxish.png\", \"assets/shiny/bruxish.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(780,\"Drampa\", \"assets/regular/drampa.png\", \"assets/shiny/drampa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(781,\"Dhelmise\", \"assets/regular/dhelmise.png\", \"assets/shiny/dhelmise.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(782,\"Jangmo-o\", \"assets/regular/jangmo-o.png\", \"assets/shiny/jangmo-o.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(783,\"Hakamo-o\", \"assets/regular/hakamo-o.png\", \"assets/shiny/hakamo-o.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(784,\"Kommo-o\", \"assets/regular/kommo-o.png\", \"assets/shiny/kommo-o.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(785,\"Tapu Koko\", \"assets/regular/tapu koko.png\", \"assets/shiny/tapu koko.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(786,\"Tapu Lele\", \"assets/regular/tapu lele.png\", \"assets/shiny/tapu lele.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(787,\"Tapu Bulu\", \"assets/regular/tapu bulu.png\", \"assets/shiny/tapu bulu.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(788,\"Tapu Fini\", \"assets/regular/tapu fini.png\", \"assets/shiny/tapu fini.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(789,\"Cosmog\", \"assets/regular/cosmog.png\", \"assets/shiny/cosmog.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(790,\"Cosmoem\", \"assets/regular/cosmoem.png\", \"assets/shiny/cosmoem.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(791,\"Solgaleo\", \"assets/regular/solgaleo.png\", \"assets/shiny/solgaleo.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(792,\"Lunala\", \"assets/regular/lunala.png\", \"assets/shiny/lunala.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(793,\"Nihilego\", \"assets/regular/nihilego.png\", \"assets/shiny/nihilego.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(794,\"Buzzwole\", \"assets/regular/buzzwole.png\", \"assets/shiny/buzzwole.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(795,\"Pheromosa\", \"assets/regular/pheromosa.png\", \"assets/shiny/pheromosa.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(796,\"Xurkitree\", \"assets/regular/xurkitree.png\", \"assets/shiny/xurkitree.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(797,\"Celesteela\", \"assets/regular/celesteela.png\", \"assets/shiny/celesteela.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(798,\"Kartana\", \"assets/regular/kartana.png\", \"assets/shiny/kartana.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(799,\"Guzzlord\", \"assets/regular/guzzlord.png\", \"assets/shiny/guzzlord.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(800,\"Necrozma\", \"assets/regular/necrozma.png\", \"assets/shiny/necrozma.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(801,\"Magearna\", \"assets/regular/magearna.png\", \"assets/shiny/magearna.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(802,\"Marshadow\", \"assets/regular/marshadow.png\", \"assets/shiny/marshadow.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(803,\"Poipole\", \"assets/regular/poipole.png\", \"assets/shiny/poipole.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(804,\"Naganadel\", \"assets/regular/naganadel.png\", \"assets/shiny/naganadel.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(805,\"Stakataka\", \"assets/regular/stakataka.png\", \"assets/shiny/stakataka.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(806,\"Blacephalon\", \"assets/regular/blacephalon.png\", \"assets/shiny/blacephalon.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(807,\"Zeraora\", \"assets/regular/zeraora.png\", \"assets/shiny/zeraora.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(808,\"Meltan\", \"assets/regular/meltan.png\", \"assets/shiny/meltan.png\")");
          db.execute("INSERT INTO Pokemon (national_number, name, sprite_url, shiny_sprite_url) values(809,\"Melmetal\", \"assets/regular/melmetal.png\", \"assets/shiny/melmetal.png\")");

          db.execute("INSERT INTO game (id, name) values(1,\"Red\")");
          db.execute("INSERT INTO game (id, name) values(2,\"Green\")");
          db.execute("INSERT INTO game (id, name) values(3,\"Blue\")");
          db.execute("INSERT INTO game (id, name) values(4,\"Yellow\")");
          db.execute("INSERT INTO game (id, name) values(5,\"Gold\")");
          db.execute("INSERT INTO game (id, name) values(6,\"Silver\")");
          db.execute("INSERT INTO game (id, name) values(7,\"Crystal\")");
          db.execute("INSERT INTO game (id, name) values(8,\"Ruby\")");
          db.execute("INSERT INTO game (id, name) values(9,\"Sapphire\")");
          db.execute("INSERT INTO game (id, name) values(10,\"Emerald\")");
          db.execute("INSERT INTO game (id, name) values(11,\"FireRed\")");
          db.execute("INSERT INTO game (id, name) values(12,\"LeafGreen\")");
          db.execute("INSERT INTO game (id, name) values(13,\"Diamond\")");
          db.execute("INSERT INTO game (id, name) values(14,\"Pearl\")");
          db.execute("INSERT INTO game (id, name) values(15,\"Platinum\")");
          db.execute("INSERT INTO game (id, name) values(16,\"HeartGold\")");
          db.execute("INSERT INTO game (id, name) values(17,\"SoulSilver\")");
          db.execute("INSERT INTO game (id, name) values(18,\"Black\")");
          db.execute("INSERT INTO game (id, name) values(19,\"White\")");
          db.execute("INSERT INTO game (id, name) values(20,\"Black 2\")");
          db.execute("INSERT INTO game (id, name) values(21,\"White 2\")");
          db.execute("INSERT INTO game (id, name) values(22,\"X\")");
          db.execute("INSERT INTO game (id, name) values(23,\"Y\")");
          db.execute("INSERT INTO game (id, name) values(24,\"Omega Ruby\")");
          db.execute("INSERT INTO game (id, name) values(25,\"Alpha Sapphire\")");
          db.execute("INSERT INTO game (id, name) values(26,\"Sun\")");
          db.execute("INSERT INTO game (id, name) values(27,\"Moon\")");
          db.execute("INSERT INTO game (id, name) values(28,\"Ultra Sun\")");
          db.execute("INSERT INTO game (id, name) values(29,\"Ultra Moon\")");
          db.execute("INSERT INTO game (id, name) values(30,\"Let's Go, Pikachu!\")");
          db.execute("INSERT INTO game (id, name) values(31,\"Let's Go, Eevee\")");

          await batch.commit();

          var pokemonLists =
               [generatePokemonList(1,151, [],[]),
                generatePokemonList(1,151, [],[]),
                generatePokemonList(1,151, [],[]),
                generatePokemonList(1,151, [],[]),
                generatePokemonList(1,252, [],[]),
                generatePokemonList(1,252, [],[]),
                generatePokemonList(1,252, [],[]),
                generatePokemonList(1,386, [],[]),
                generatePokemonList(1,386, [],[]),
                generatePokemonList(1,386, [],[]),
                generatePokemonList(1,386, [],[]),
                generatePokemonList(1,386, [],[]),
                generatePokemonList(1,493, [],[]),
                generatePokemonList(1,493, [],[]),
                generatePokemonList(1,493, [],[]),
                generatePokemonList(1,493, [],[]),
                generatePokemonList(1,493, [],[]),
                generatePokemonList(1,649, [],[]),
                generatePokemonList(1,649, [],[]),
                generatePokemonList(1,649, [],[]),
                generatePokemonList(1,649, [],[]),
                generatePokemonList(1,721, [],[]),
                generatePokemonList(1,721, [],[]),
                generatePokemonList(1,721, [],[]),
                generatePokemonList(1,721, [],[]),
                generatePokemonList(1,807, [],[]),
                generatePokemonList(1,807, [],[]),
                generatePokemonList(1,807, [],[]),
                generatePokemonList(1,807, [],[]),
                generatePokemonList(1,151, [],[808,809]),
                generatePokemonList(1,151, [],[808,809])];

          var pokemon = await getAllPokemon();

          pokemonLists.asMap().forEach((index, pokemonList){
                pokemonList.forEach((pokemonNumber){
                      var pokemonId = pokemon.firstWhere((pokemon) => pokemon.nationalNumber == pokemonNumber).id;
                      db.insert(pokemonGameTableName, { 'pokemon_id': pokemonId, 'game_id': index+1, });
                });
          });


        });
    didInit = true;
  }

  List generatePokemonList(start,finish,List skipped,List extras){
        var pokemonList = [for(var i=start; i<=finish; i+=1) i];
        skipped.forEach((poke) => pokemonList.remove(poke));
        return [...pokemonList, ...extras];
  }

  Future<Livingdex> getLivingdex(int id) async {
    var db = await _getDb();
    var result = await db.query(livingdexTableName,  where: 'id = ?', whereArgs: [id]);
    if (result.length > 0) return Livingdex.fromMap(result.first);
    return null;
  }

  Future<List<Livingdex>> listLivingdexes() async {
    var db = await _getDb();
    var result = await db.query(livingdexTableName);
    List<Livingdex> livingdexes = [];
    for(Map<String, dynamic> item in result) {
      livingdexes.add(Livingdex.fromMap(item));
    }
    return livingdexes;
  }

  Future<List<Game>> listGames() async {
    var db = await _getDb();
    var result = await db.query(gameTableName);
    List<Game> games = [];
    for(Map<String, dynamic> item in result) {
      games.add(Game.fromMap(item));
    }
    return games;
  }

  /* resultMapToList(List<Map<String, dynamic>> resultMap, objectFromMap){
    var objectList = [];
    for(Map<String, dynamic> item in resultMap) {
      objectList.add(objectFromMap(item));
    }
    return objectList;
  }
*/

  createLivingdex(Livingdex livingdex) async {
    var db = await _getDb();
    db.insert(livingdexTableName, livingdex.toMap());
  }

  deleteLivingdex(int id) async {
    var db = await _getDb();
    db.delete(livingdexTableName, where: "id = ?", whereArgs: [id]);
  }

  capturePokemon(int livingdexId, int pokemonId) async {
    var db = await _getDb();
    db.insert(capturedTableName, { 'livingdex_id': livingdexId, 'pokemon_id': pokemonId, });
  }

  releasePokemon(int livingdexId, int pokemonId) async {
    var db = await _getDb();
    db.delete(capturedTableName, where: "livingdex_id = ? AND pokemon_id = ?", whereArgs: [livingdexId, pokemonId]);
  }

/*
  /// Get all pokemons by livingdex Id, will return a list with all the pokemons captured in that livingdex
  Future<List<Pokemon>> getPokemonsByLivingdexId(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT $pokemonTableName.*'
            'FROM $pokemonTableName '
            'JOIN $capturedTableName '
            'ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id} '
            'AND $capturedTableName.livingdex_id = "$id" ');
    var pokemons = [];
    for(Map<String, dynamic> item in result) {
      pokemons.add(new Pokemon.fromMap(item));
    }
    return pokemons;
  }
*/

  Future<List<Pokemon>> getCapturedPokemons(int livingdexId) async {
    var db = await _getDb();
    var pokemonsMapList = await db.query('$pokemonTableName INNER JOIN $capturedTableName ON $capturedTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id}',
        where:'$capturedTableName.livingdex_id = ?', whereArgs: [livingdexId]);
    List<Pokemon> pokemons = [];
    for(Map<String, dynamic> item in pokemonsMapList) {
      pokemons.add(Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future<List<Pokemon>> getNationalDex(int gameId) async {
    var db = await _getDb();
    var pokemonsMapList = await db.query('$pokemonTableName INNER JOIN $pokemonGameTableName ON $pokemonGameTableName.pokemon_id = $pokemonTableName.${Pokemon.db_id}',
        where:'$pokemonGameTableName.game_id = ?', whereArgs: [gameId]);
    List<Pokemon> pokemons = [];
    for(Map<String, dynamic> item in pokemonsMapList) {
      pokemons.add(Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future<List<Pokemon>> getAllPokemon() async {
    var db = await _getDb();
    var pokemonsMapList = await db.query(pokemonTableName);
    List<Pokemon> pokemons = [];
    for(Map<String, dynamic> item in pokemonsMapList) {
      pokemons.add(Pokemon.fromMap(item));
    }
    return pokemons;
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }
}