import 'package:living_dex_tracker/data/LDTDatabase.dart';

class Repository {

  static final Repository _repo = new Repository._internal();

  LDTDatabase database;

  static Repository get() {
    return _repo;
  }

  Repository._internal() {
    database = LDTDatabase.get();
  }
}