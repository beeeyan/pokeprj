import 'package:path/path.dart';
import 'package:pokeprj/consts/db.dart';
import 'package:pokeprj/favorite.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), favFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $favTableName(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }
static Future<void> create(Favorite fav) async {
    var db = await openDb();
    await db.insert(
      favTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
