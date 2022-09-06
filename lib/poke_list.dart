import 'package:flutter/material.dart';
import 'package:pokeprj/consts/pokeapi.dart';
import 'package:pokeprj/favorite.dart';
import 'package:pokeprj/notifier/favorites_notifier.dart';
import 'package:pokeprj/notifier/pokemons_notifier.dart';
import 'package:pokeprj/poke_grid_item.dart';
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
  bool isGridMode = true;

  // 表示個数
  int itemCount(int favLength, int page) {
    int ret = page * pageSize;

    if (isFavoriteMode && ret > favLength) {
      ret = favLength;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1; // 通常モード
    if (isFavoriteMode && index < favs.length) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favLength, int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favLength) {
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

  void changeFavMode(bool currentMode) {
    setState(() => isFavoriteMode = !currentMode);
  }

  void changeGridMode(bool currentMode) {
    setState(() => isGridMode = !currentMode);
  }

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
                  await showModalBottomSheet<bool>(
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
                        changeFavMode: changeFavMode,
                        isGridMode: isGridMode,
                        changeGridMode: changeGridMode,
                      );
                    },
                  );
                },
              )),
          Expanded(
            child: Consumer<PokemonsNotifier>(
              builder: (context, pokes, child) {
                if (itemCount(favs.favs.length, _currentPage) == 0) {
                  return const Text('no data');
                } else {
                  if (isGridMode) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            itemCount(favs.favs.length, _currentPage)) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: OutlinedButton(
                              child: const Text('more'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed:
                                  isLastPage(favs.favs.length, _currentPage)
                                      ? null
                                      : () => {
                                            setState(() => _currentPage++),
                                          },
                            ),
                          );
                        } else {
                          return PokeGridItem(
                            poke: pokes.byId(itemId(favs.favs, index)),
                          );
                        }
                      },
                    );
                  } else {
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        itemCount:
                            itemCount(favs.favs.length, _currentPage) + 1,
                        itemBuilder: (context, index) {
                          if (index ==
                              itemCount(favs.favs.length, _currentPage)) {
                            return OutlinedButton(
                              child: const Text('more'),
                              onPressed:
                                  isLastPage(favs.favs.length, _currentPage)
                                      ? null
                                      : () => {
                                            setState(() => _currentPage++),
                                          },
                            );
                          } else {
                            return PokeListItem(
                              poke: pokes.byId(itemId(favs.favs, index)),
                            );
                          }
                        });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
