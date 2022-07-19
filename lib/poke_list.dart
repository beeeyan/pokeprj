import 'package:flutter/material.dart';
import 'package:pokeprj/consts/pokeapi.dart';
import 'package:pokeprj/favorite.dart';
import 'package:pokeprj/notifier/favorites_notifier.dart';
import 'package:pokeprj/notifier/pokemons_notifier.dart';
import 'package:pokeprj/poke_list_item.dart';
import 'package:pokeprj/view_mode_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  bool isFavoriteMode = false;
  int _currentPage = 1;

  // 表示個数
  int itemCount(int page) {
    int ret = page * pageSize;

    if (isFavoriteMode && ret > favMock.length) {
      ret = favMock.length;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(int index) {
    int ret = index + 1; // 通常モード
    if (isFavoriteMode) {
      ret = favMock[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favMock.length) {
        return false;
      }
      return true;
      // 通常モードの場合
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  void changeMode(bool currentMode) {
    setState(() => isFavoriteMode = !currentMode);
  }

  List<Favorite> favMock = [
    Favorite(pokeId: 1),
    Favorite(pokeId: 4),
    Favorite(pokeId: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, favs, child) => Column(
        children: [
          Container(
              height: 24,
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.auto_awesome_outlined),
                onPressed: () async {
                  var ret = await showModalBottomSheet<bool>(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return ViewModeBottomSheet(
                        favMode: isFavoriteMode,
                      );
                    },
                  );
                  if (ret != null && ret) {
                    changeMode(isFavoriteMode);
                  }
                },
              )),
          Expanded(
            child: Consumer<PokemonsNotifier>(
                builder: (context, pokes, child) => ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    itemCount: itemCount(_currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(_currentPage)) {
                        return OutlinedButton(
                          child: const Text('more'),
                          onPressed: isLastPage(_currentPage)
                              ? null
                              : () => {
                                    setState(() => _currentPage++),
                                  },
                        );
                      } else {
                        return PokeListItem(
                          poke: pokes.byId(itemId(index)),
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
