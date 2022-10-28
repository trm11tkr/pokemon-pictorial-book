import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/db/favorites.dart';

class FavoritesNotifier extends ChangeNotifier {
  FavoritesNotifier() {
    syncDb();
  }

  final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  void toggle(Favorite fav) {
    if (isExist(fav.pokeId)) {
      delete(fav.pokeId);
    } else {
      add(fav);
    }
  }

  bool isExist(int id) {
    if (_favs.indexWhere((fav) => fav.pokeId == id) < 0) {
      return false;
    }
    return true;
  }

  void syncDb() async {
    FavoritesDb.read().then(
      (val) => _favs
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(Favorite fav) async {
    await FavoritesDb.create(fav);
    syncDb();
  }

  void delete(int id) async {
    await FavoritesDb.delete(id);
    syncDb();
    // エラー処理あった方が良い
  }
}

class Favorite {
  Favorite({required this.pokeId});

  int pokeId;

  Map<String, dynamic> toMap() {
    return {
      'id': pokeId,
    };
  }
}
