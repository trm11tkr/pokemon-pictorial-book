import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  void add(Favorite fav) {
    favs.add(fav);
    notifyListeners();
  }

  void delete(Favorite fav) {
    var res = favs.remove(fav);
    if (res) {
      notifyListeners();
    }
    // todo: error process
  }
}

class Favorite {
  Favorite({required this.pokeId});

  int pokeId;
}
