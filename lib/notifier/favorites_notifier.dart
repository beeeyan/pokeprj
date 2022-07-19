import 'package:flutter/material.dart';
import 'package:pokeprj/favorite.dart';

class FavoritesNotifier extends ChangeNotifier {
    final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  // お気に入り追加
  void add(Favorite fav) {
    favs.add(fav);
    // 状態の通知
    notifyListeners();
  }

  void delete(Favorite fav) {
    var res = favs.remove(fav);
    if (res) {
      notifyListeners();
    }
    // エラー処理あった方が良い
  }
}