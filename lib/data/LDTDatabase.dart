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
          await db.execute(
              "CREATE TABLE $pokemonTableName ("
                  "${Pokemon.db_id} INTEGER PRIMARY KEY,"
                  "${Pokemon.db_name} TEXT,"
                  "${Pokemon.db_national_number} INTEGER,"
                  "${Pokemon.db_sprite_url} TEXT,"
                  "${Pokemon.db_shiny_sprite_url} TEXT"
                  ")");
          await db.execute(
              "CREATE TABLE $gameTableName ("
                  "${Game.db_id} INTEGER PRIMARY KEY,"
                  "${Game.db_name} TEXT"
                  ")");
          await db.execute("CREATE TABLE $livingdexTableName ("
              "${Livingdex.db_id} INTEGER PRIMARY KEY,"
              "${Livingdex.db_name} TEXT,"
              "${Livingdex.db_shiny} INTEGER,"
              "${Livingdex.db_national} INTEGER,"
              "${Livingdex.db_gameId} INTEGER,"
              "FOREIGN KEY(${Livingdex.db_gameId}) REFERENCES $gameTableName(${Game.db_id})"
              ")");
          await db.execute("CREATE TABLE $capturedTableName ("
              "id INTEGER PRIMARY KEY, "
              "pokemon_id INTEGER,"
              "livingdex_id INTEGER,"
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(livingdex_id) REFERENCES $livingdexTableName(${Livingdex.db_id})"
              ")");
          await db.execute("CREATE TABLE $pokemonGameTableName ("
              "id INTEGER PRIMARY KEY, "
              "regional_id INTEGER,"
              "pokemon_id INTEGER,"
              "game_id INTEGER,"
              "FOREIGN KEY(pokemon_id) REFERENCES $pokemonTableName(${Pokemon.db_id}), "
              "FOREIGN KEY(game_id) REFERENCES $livingdexTableName(${Game.db_id})"
              ")");

          await db.execute("INSERT INTO Pokemon (national_number, name) values(1,\"Bulbasaur\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(2,\"Ivysaur\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(3,\"Venusaur\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(4,\"Charmander\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(5,\"Charmeleon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(6,\"Charizard\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(7,\"Squirtle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(8,\"Wartortle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(9,\"Blastoise\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(10,\"Caterpie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(11,\"Metapod\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(12,\"Butterfree\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(13,\"Weedle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(14,\"Kakuna\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(15,\"Beedrill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(16,\"Pidgey\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(17,\"Pidgeotto\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(18,\"Pidgeot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(19,\"Rattata\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(20,\"Raticate\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(21,\"Spearow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(22,\"Fearow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(23,\"Ekans\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(24,\"Arbok\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(25,\"Pikachu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(26,\"Raichu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(27,\"Sandshrew\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(28,\"Sandslash\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(29,\"Nidoran♀\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(30,\"Nidorina\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(31,\"Nidoqueen\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(32,\"Nidoran♂\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(33,\"Nidorino\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(34,\"Nidoking\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(35,\"Clefairy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(36,\"Clefable\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(37,\"Vulpix\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(38,\"Ninetales\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(39,\"Jigglypuff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(40,\"Wigglytuff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(41,\"Zubat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(42,\"Golbat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(43,\"Oddish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(44,\"Gloom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(45,\"Vileplume\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(46,\"Paras\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(47,\"Parasect\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(48,\"Venonat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(49,\"Venomoth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(50,\"Diglett\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(51,\"Dugtrio\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(52,\"Meowth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(53,\"Persian\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(54,\"Psyduck\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(55,\"Golduck\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(56,\"Mankey\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(57,\"Primeape\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(58,\"Growlithe\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(59,\"Arcanine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(60,\"Poliwag\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(61,\"Poliwhirl\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(62,\"Poliwrath\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(63,\"Abra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(64,\"Kadabra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(65,\"Alakazam\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(66,\"Machop\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(67,\"Machoke\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(68,\"Machamp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(69,\"Bellsprout\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(70,\"Weepinbell\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(71,\"Victreebel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(72,\"Tentacool\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(73,\"Tentacruel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(74,\"Geodude\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(75,\"Graveler\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(76,\"Golem\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(77,\"Ponyta\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(78,\"Rapidash\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(79,\"Slowpoke\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(80,\"Slowbro\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(81,\"Magnemite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(82,\"Magneton\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(83,\"Farfetc\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(84,\"Doduo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(85,\"Dodrio\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(86,\"Seel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(87,\"Dewgong\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(88,\"Grimer\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(89,\"Muk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(90,\"Shellder\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(91,\"Cloyster\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(92,\"Gastly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(93,\"Haunter\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(94,\"Gengar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(95,\"Onix\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(96,\"Drowzee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(97,\"Hypno\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(98,\"Krabby\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(99,\"Kingler\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(100,\"Voltorb\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(101,\"Electrode\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(102,\"Exeggcute\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(103,\"Exeggutor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(104,\"Cubone\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(105,\"Marowak\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(106,\"Hitmonlee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(107,\"Hitmonchan\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(108,\"Lickitung\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(109,\"Koffing\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(110,\"Weezing\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(111,\"Rhyhorn\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(112,\"Rhydon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(113,\"Chansey\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(114,\"Tangela\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(115,\"Kangaskhan\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(116,\"Horsea\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(117,\"Seadra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(118,\"Goldeen\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(119,\"Seaking\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(120,\"Staryu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(121,\"Starmie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(122,\"MrMime\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(123,\"Scyther\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(124,\"Jynx\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(125,\"Electabuzz\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(126,\"Magmar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(127,\"Pinsir\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(128,\"Tauros\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(129,\"Magikarp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(130,\"Gyarados\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(131,\"Lapras\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(132,\"Ditto\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(133,\"Eevee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(134,\"Vaporeon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(135,\"Jolteon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(136,\"Flareon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(137,\"Porygon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(138,\"Omanyte\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(139,\"Omastar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(140,\"Kabuto\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(141,\"Kabutops\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(142,\"Aerodactyl\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(143,\"Snorlax\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(144,\"Articuno\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(145,\"Zapdos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(146,\"Moltres\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(147,\"Dratini\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(148,\"Dragonair\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(149,\"Dragonite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(150,\"Mewtwo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(151,\"Mew\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(152,\"Chikorita\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(153,\"Bayleef\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(154,\"Meganium\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(155,\"Cyndaquil\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(156,\"Quilava\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(157,\"Typhlosion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(158,\"Totodile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(159,\"Croconaw\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(160,\"Feraligatr\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(161,\"Sentret\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(162,\"Furret\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(163,\"Hoothoot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(164,\"Noctowl\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(165,\"Ledyba\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(166,\"Ledian\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(167,\"Spinarak\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(168,\"Ariados\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(169,\"Crobat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(170,\"Chinchou\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(171,\"Lanturn\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(172,\"Pichu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(173,\"Cleffa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(174,\"Igglybuff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(175,\"Togepi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(176,\"Togetic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(177,\"Natu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(178,\"Xatu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(179,\"Mareep\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(180,\"Flaaffy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(181,\"Ampharos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(182,\"Bellossom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(183,\"Marill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(184,\"Azumarill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(185,\"Sudowoodo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(186,\"Politoed\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(187,\"Hoppip\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(188,\"Skiploom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(189,\"Jumpluff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(190,\"Aipom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(191,\"Sunkern\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(192,\"Sunflora\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(193,\"Yanma\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(194,\"Wooper\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(195,\"Quagsire\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(196,\"Espeon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(197,\"Umbreon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(198,\"Murkrow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(199,\"Slowking\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(200,\"Misdreavus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(201,\"Unown\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(202,\"Wobbuffet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(203,\"Girafarig\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(204,\"Pineco\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(205,\"Forretress\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(206,\"Dunsparce\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(207,\"Gligar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(208,\"Steelix\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(209,\"Snubbull\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(210,\"Granbull\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(211,\"Qwilfish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(212,\"Scizor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(213,\"Shuckle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(214,\"Heracross\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(215,\"Sneasel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(216,\"Teddiursa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(217,\"Ursaring\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(218,\"Slugma\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(219,\"Magcargo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(220,\"Swinub\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(221,\"Piloswine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(222,\"Corsola\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(223,\"Remoraid\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(224,\"Octillery\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(225,\"Delibird\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(226,\"Mantine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(227,\"Skarmory\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(228,\"Houndour\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(229,\"Houndoom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(230,\"Kingdra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(231,\"Phanpy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(232,\"Donphan\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(233,\"Porygon2\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(234,\"Stantler\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(235,\"Smeargle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(236,\"Tyrogue\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(237,\"Hitmontop\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(238,\"Smoochum\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(239,\"Elekid\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(240,\"Magby\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(241,\"Miltank\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(242,\"Blissey\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(243,\"Raikou\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(244,\"Entei\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(245,\"Suicune\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(246,\"Larvitar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(247,\"Pupitar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(248,\"Tyranitar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(249,\"Lugia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(250,\"Ho-oh\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(251,\"Celebi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(252,\"Treecko\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(253,\"Grovyle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(254,\"Sceptile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(255,\"Torchic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(256,\"Combusken\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(257,\"Blaziken\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(258,\"Mudkip\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(259,\"Marshtomp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(260,\"Swampert\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(261,\"Poochyena\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(262,\"Mightyena\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(263,\"Zigzagoon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(264,\"Linoone\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(265,\"Wurmple\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(266,\"Silcoon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(267,\"Beautifly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(268,\"Cascoon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(269,\"Dustox\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(270,\"Lotad\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(271,\"Lombre\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(272,\"Ludicolo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(273,\"Seedot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(274,\"Nuzleaf\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(275,\"Shiftry\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(276,\"Taillow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(277,\"Swellow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(278,\"Wingull\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(279,\"Pelipper\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(280,\"Ralts\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(281,\"Kirlia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(282,\"Gardevoir\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(283,\"Surskit\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(284,\"Masquerain\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(285,\"Shroomish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(286,\"Breloom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(287,\"Slakoth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(288,\"Vigoroth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(289,\"Slaking\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(290,\"Nincada\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(291,\"Ninjask\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(292,\"Shedinja\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(293,\"Whismur\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(294,\"Loudred\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(295,\"Exploud\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(296,\"Makuhita\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(297,\"Hariyama\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(298,\"Azurill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(299,\"Nosepass\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(300,\"Skitty\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(301,\"Delcatty\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(302,\"Sableye\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(303,\"Mawile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(304,\"Aron\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(305,\"Lairon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(306,\"Aggron\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(307,\"Meditite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(308,\"Medicham\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(309,\"Electrike\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(310,\"Manectric\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(311,\"Plusle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(312,\"Minun\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(313,\"Volbeat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(314,\"Illumise\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(315,\"Roselia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(316,\"Gulpin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(317,\"Swalot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(318,\"Carvanha\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(319,\"Sharpedo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(320,\"Wailmer\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(321,\"Wailord\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(322,\"Numel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(323,\"Camerupt\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(324,\"Torkoal\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(325,\"Spoink\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(326,\"Grumpig\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(327,\"Spinda\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(328,\"Trapinch\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(329,\"Vibrava\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(330,\"Flygon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(331,\"Cacnea\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(332,\"Cacturne\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(333,\"Swablu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(334,\"Altaria\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(335,\"Zangoose\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(336,\"Seviper\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(337,\"Lunatone\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(338,\"Solrock\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(339,\"Barboach\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(340,\"Whiscash\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(341,\"Corphish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(342,\"Crawdaunt\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(343,\"Baltoy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(344,\"Claydol\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(345,\"Lileep\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(346,\"Cradily\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(347,\"Anorith\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(348,\"Armaldo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(349,\"Feebas\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(350,\"Milotic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(351,\"Castform\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(352,\"Kecleon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(353,\"Shuppet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(354,\"Banette\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(355,\"Duskull\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(356,\"Dusclops\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(357,\"Tropius\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(358,\"Chimecho\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(359,\"Absol\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(360,\"Wynaut\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(361,\"Snorunt\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(362,\"Glalie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(363,\"Spheal\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(364,\"Sealeo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(365,\"Walrein\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(366,\"Clamperl\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(367,\"Huntail\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(368,\"Gorebyss\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(369,\"Relicanth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(370,\"Luvdisc\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(371,\"Bagon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(372,\"Shelgon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(373,\"Salamence\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(374,\"Beldum\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(375,\"Metang\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(376,\"Metagross\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(377,\"Regirock\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(378,\"Regice\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(379,\"Registeel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(380,\"Latias\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(381,\"Latios\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(382,\"Kyogre\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(383,\"Groudon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(384,\"Rayquaza\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(385,\"Jirachi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(386,\"Deoxys\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(387,\"Turtwig\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(388,\"Grotle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(389,\"Torterra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(390,\"Chimchar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(391,\"Monferno\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(392,\"Infernape\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(393,\"Piplup\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(394,\"Prinplup\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(395,\"Empoleon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(396,\"Starly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(397,\"Staravia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(398,\"Staraptor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(399,\"Bidoof\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(400,\"Bibarel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(401,\"Kricketot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(402,\"Kricketune\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(403,\"Shinx\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(404,\"Luxio\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(405,\"Luxray\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(406,\"Budew\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(407,\"Roserade\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(408,\"Cranidos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(409,\"Rampardos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(410,\"Shieldon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(411,\"Bastiodon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(412,\"Burmy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(413,\"Wormadam\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(414,\"Mothim\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(415,\"Combee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(416,\"Vespiquen\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(417,\"Pachirisu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(418,\"Buizel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(419,\"Floatzel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(420,\"Cherubi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(421,\"Cherrim\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(422,\"Shellos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(423,\"Gastrodon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(424,\"Ambipom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(425,\"Drifloon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(426,\"Drifblim\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(427,\"Buneary\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(428,\"Lopunny\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(429,\"Mismagius\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(430,\"Honchkrow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(431,\"Glameow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(432,\"Purugly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(433,\"Chingling\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(434,\"Stunky\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(435,\"Skuntank\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(436,\"Bronzor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(437,\"Bronzong\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(438,\"Bonsly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(439,\"Mime\" )");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(440,\"Happiny\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(441,\"Chatot\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(442,\"Spiritomb\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(443,\"Gible\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(444,\"Gabite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(445,\"Garchomp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(446,\"Munchlax\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(447,\"Riolu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(448,\"Lucario\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(449,\"Hippopotas\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(450,\"Hippowdon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(451,\"Skorupi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(452,\"Drapion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(453,\"Croagunk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(454,\"Toxicroak\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(455,\"Carnivine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(456,\"Finneon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(457,\"Lumineon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(458,\"Mantyke\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(459,\"Snover\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(460,\"Abomasnow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(461,\"Weavile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(462,\"Magnezone\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(463,\"Lickilicky\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(464,\"Rhyperior\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(465,\"Tangrowth\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(466,\"Electivire\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(467,\"Magmortar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(468,\"Togekiss\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(469,\"Yanmega\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(470,\"Leafeon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(471,\"Glaceon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(472,\"Gliscor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(473,\"Mamoswine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(474,\"Porygo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(475,\"Gallade\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(476,\"Probopass\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(477,\"Dusknoir\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(478,\"Froslass\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(479,\"Rotom\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(480,\"Uxie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(481,\"Mesprit\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(482,\"Azelf\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(483,\"Dialga\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(484,\"Palkia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(485,\"Heatran\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(486,\"Regigigas\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(487,\"Giratina\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(488,\"Cresselia\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(489,\"Phione\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(490,\"Manaphy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(491,\"Darkrai\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(492,\"Shaymin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(493,\"Arceus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(494,\"Victini\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(495,\"Snivy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(496,\"Servine\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(497,\"Serperior\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(498,\"Tepig\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(499,\"Pignite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(500,\"Emboar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(501,\"Oshawott\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(502,\"Dewott\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(503,\"Samurott\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(504,\"Patrat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(505,\"Watchog\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(506,\"Lillipup\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(507,\"Herdier\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(508,\"Stoutland\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(509,\"Purrloin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(510,\"Liepard\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(511,\"Pansage\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(512,\"Simisage\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(513,\"Pansear\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(514,\"Simisear\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(515,\"Panpour\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(516,\"Simipour\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(517,\"Munna\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(518,\"Musharna\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(519,\"Pidove\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(520,\"Tranquill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(521,\"Unfezant\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(522,\"Blitzle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(523,\"Zebstrika\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(524,\"Roggenrola\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(525,\"Boldore\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(526,\"Gigalith\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(527,\"Woobat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(528,\"Swoobat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(529,\"Drilbur\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(530,\"Excadrill\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(531,\"Audino\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(532,\"Timburr\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(533,\"Gurdurr\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(534,\"Conkeldurr\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(535,\"Tympole\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(536,\"Palpitoad\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(537,\"Seismitoad\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(538,\"Throh\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(539,\"Sawk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(540,\"Sewaddle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(541,\"Swadloon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(542,\"Leavanny\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(543,\"Venipede\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(544,\"Whirlipede\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(545,\"Scolipede\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(546,\"Cottonee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(547,\"Whimsicott\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(548,\"Petilil\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(549,\"Lilligant\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(550,\"Basculin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(551,\"Sandile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(552,\"Krokorok\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(553,\"Krookodile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(554,\"Darumaka\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(555,\"Darmanitan\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(556,\"Maractus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(557,\"Dwebble\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(558,\"Crustle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(559,\"Scraggy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(560,\"Scrafty\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(561,\"Sigilyph\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(562,\"Yamask\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(563,\"Cofagrigus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(564,\"Tirtouga\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(565,\"Carracosta\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(566,\"Archen\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(567,\"Archeops\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(568,\"Trubbish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(569,\"Garbodor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(570,\"Zorua\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(571,\"Zoroark\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(572,\"Minccino\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(573,\"Cinccino\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(574,\"Gothita\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(575,\"Gothorita\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(576,\"Gothitelle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(577,\"Solosis\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(578,\"Duosion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(579,\"Reuniclus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(580,\"Ducklett\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(581,\"Swanna\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(582,\"Vanillite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(583,\"Vanillish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(584,\"Vanilluxe\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(585,\"Deerling\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(586,\"Sawsbuck\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(587,\"Emolga\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(588,\"Karrablast\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(589,\"Escavalier\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(590,\"Foongus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(591,\"Amoonguss\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(592,\"Frillish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(593,\"Jellicent\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(594,\"Alomomola\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(595,\"Joltik\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(596,\"Galvantula\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(597,\"Ferroseed\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(598,\"Ferrothorn\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(599,\"Klink\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(600,\"Klang\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(601,\"Klinklang\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(602,\"Tynamo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(603,\"Eelektrik\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(604,\"Eelektross\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(605,\"Elgyem\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(606,\"Beheeyem\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(607,\"Litwick\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(608,\"Lampent\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(609,\"Chandelure\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(610,\"Axew\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(611,\"Fraxure\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(612,\"Haxorus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(613,\"Cubchoo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(614,\"Beartic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(615,\"Cryogonal\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(616,\"Shelmet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(617,\"Accelgor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(618,\"Stunfisk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(619,\"Mienfoo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(620,\"Mienshao\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(621,\"Druddigon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(622,\"Golett\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(623,\"Golurk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(624,\"Pawniard\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(625,\"Bisharp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(626,\"Bouffalant\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(627,\"Rufflet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(628,\"Braviary\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(629,\"Vullaby\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(630,\"Mandibuzz\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(631,\"Heatmor\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(632,\"Durant\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(633,\"Deino\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(634,\"Zweilous\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(635,\"Hydreigon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(636,\"Larvesta\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(637,\"Volcarona\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(638,\"Cobalion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(639,\"Terrakion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(640,\"Virizion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(641,\"Tornadus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(642,\"Thundurus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(643,\"Reshiram\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(644,\"Zekrom \")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(645,\"Landorus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(646,\"Kyurem\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(647,\"Keldeo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(648,\"Meloetta\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(649,\"Genesect\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(650,\"Chespin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(651,\"Quilladin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(652,\"Chesnaught\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(653,\"Fennekin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(654,\"Braixen\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(655,\"Delphox\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(656,\"Froakie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(657,\"Frogadier\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(658,\"Greninja\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(659,\"Bunnelby\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(660,\"Diggersby\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(661,\"Fletchling\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(662,\"Fletchinder\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(663,\"Talonflame\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(664,\"Scatterbug\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(665,\"Spewpa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(666,\"Vivillon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(667,\"Litleo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(668,\"Pyroar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(669,\"Flabébé\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(670,\"Floette\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(671,\"Florges\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(672,\"Skiddo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(673,\"Gogoat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(674,\"Pancham\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(675,\"Pangoro\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(676,\"Furfrou\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(677,\"Espurr\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(678,\"Meowstic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(679,\"Honedge\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(680,\"Doublade\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(681,\"Aegislash\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(682,\"Spritzee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(683,\"Aromatisse\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(684,\"Swirlix\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(685,\"Slurpuff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(686,\"Inkay\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(687,\"Malamar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(688,\"Binacle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(689,\"Barbaracle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(690,\"Skrelp\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(691,\"Dragalge\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(692,\"Clauncher\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(693,\"Clawitzer\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(694,\"Helioptile\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(695,\"Heliolisk\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(696,\"Tyrunt\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(697,\"Tyrantrum\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(698,\"Amaura\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(699,\"Aurorus\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(700,\"Sylveon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(701,\"Hawlucha\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(702,\"Dedenne\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(703,\"Carbink\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(704,\"Goomy\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(705,\"Sliggoo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(706,\"Goodra\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(707,\"Klefki\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(708,\"Phantump\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(709,\"Trevenant\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(710,\"Pumpkaboo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(711,\"Gourgeist\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(712,\"Bergmite\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(713,\"Avalugg\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(714,\"Noibat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(715,\"Noivern\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(716,\"Xerneas\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(717,\"Yveltal\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(718,\"Zygarde\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(719,\"Diancie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(720,\"Hoopa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(721,\"Volcanion\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(722,\"Rowlet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(723,\"Dartrix\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(724,\"Decidueye\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(725,\"Litten\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(726,\"Torracat\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(727,\"Incineroar\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(728,\"Popplio\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(729,\"Brionne\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(730,\"Primarina\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(731,\"Pikipek\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(732,\"Trumbeak\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(733,\"Toucannon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(734,\"Yungoos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(735,\"Gumshoos\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(736,\"Grubbin\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(737,\"Charjabug\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(738,\"Vikavolt\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(739,\"Crabrawler\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(740,\"Crabominable\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(741,\"Oricorio\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(742,\"Cutiefly\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(743,\"Ribombee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(744,\"Rockruff\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(745,\"Lycanroc\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(746,\"Wishiwashi\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(747,\"Mareanie\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(748,\"Toxapex\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(749,\"Mudbray\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(750,\"Mudsdale\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(751,\"Dewpider\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(752,\"Araquanid\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(753,\"Fomantis\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(754,\"Lurantis\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(755,\"Morelull\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(756,\"Shiinotic\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(757,\"Salandit\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(758,\"Salazzle\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(759,\"Stufful\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(760,\"Bewear\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(761,\"Bounsweet\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(762,\"Steenee\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(763,\"Tsareena\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(764,\"Comfey\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(765,\"Oranguru\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(766,\"Passimian\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(767,\"Wimpod\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(768,\"Golisopod\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(769,\"Sandygast\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(770,\"Palossand\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(771,\"Pyukumuku\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(772,\"Type: Null\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(773,\"Silvally\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(774,\"Minior\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(775,\"Komala\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(776,\"Turtonator\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(777,\"Togedemaru\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(778,\"Mimikyu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(779,\"Bruxish\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(780,\"Drampa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(781,\"Dhelmise\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(782,\"Jangmo-o\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(783,\"Hakamo-o\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(784,\"Kommo-o\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(785,\"Tapu Koko\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(786,\"Tapu Lele\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(787,\"Tapu Bulu\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(788,\"Tapu Fini\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(789,\"Cosmog\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(790,\"Cosmoem\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(791,\"Solgaleo\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(792,\"Lunala\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(793,\"Nihilego\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(794,\"Buzzwole\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(795,\"Pheromosa\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(796,\"Xurkitree\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(797,\"Celesteela\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(798,\"Kartana\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(799,\"Guzzlord\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(800,\"Necrozma\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(801,\"Magearna\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(802,\"Marshadow\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(803,\"Poipole\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(804,\"Naganadel\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(805,\"Stakataka\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(806,\"Blacephalon\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(807,\"Zeraora\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(808,\"Meltan\")");
          await db.execute("INSERT INTO Pokemon (national_number, name) values(809,\"Melmetal\")");

        });
    didInit = true;
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