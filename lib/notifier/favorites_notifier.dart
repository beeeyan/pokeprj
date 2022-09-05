import 'package:flutter/material.dart';
import 'package:pokeprj/db/favorites.dart';
import 'package:pokeprj/favorite.dart';

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

  // お気に入り追加
  void add(Favorite fav) async {
    await FavoritesDb.create(fav);
    syncDb();
  }

  // void delete(Favorite fav) {
  //   var res = favs.remove(fav);
  //   if (res) {
  //     notifyListeners();
  //   }
  //   // エラー処理あった方が良い
  // }

  void delete(int id) async {
    await FavoritesDb.delete(id);
    syncDb();
  }
}
