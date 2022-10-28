import 'package:pokemon_pictorial_book/const/db.dart';
import 'package:pokemon_pictorial_book/models/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), kFavFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $kFavTableName(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(Favorite fav) async {
    var db = await openDb();
    await db.insert(
      kFavTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Favorite>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(kFavTableName);
    return List.generate(maps.length, (index) {
      return Favorite(
        pokeId: maps[index]['id'],
      );
    });
  }

  //static Future<void> update(Favorite fav) async {
  //  var db = await openDb();
  //  await db.update(
  //    'favorites',
  //    fav.toMap(),
  //    where: 'id = ?',
  //    whereArgs: [fav.pokeId],
  //  );
  //  db.close();
  //}

  static Future<void> delete(int pokeId) async {
    var db = await openDb();
    await db.delete(
      kFavTableName,
      where: 'id = ?',
      whereArgs: [pokeId],
    );
  }
}
