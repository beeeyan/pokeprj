import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeprj/consts/pokeapi.dart';
import 'package:pokeprj/favorite.dart';
import 'package:pokeprj/notifier/favorites_notifier.dart';
import 'package:pokeprj/pokemon.dart';
import 'package:provider/provider.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key, required this.poke}) : super(key: key);
  final Pokemon poke;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, favs, child) => Scaffold(
        body: Container(
          color: (pokeTypeColors[poke.types.first] ?? Colors.grey[100])
              ?.withOpacity(.5),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  trailing: IconButton(
                    icon: favs.isExist(poke.id)
                        ? const Icon(Icons.star, color: Colors.orangeAccent)
                        : const Icon(Icons.star_outline),
                    onPressed: () => favs.toggle(Favorite(pokeId: poke.id)),
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Hero(
                        tag: poke.name,
                        child: CachedNetworkImage(
                          imageUrl: poke.imageUrl,
                          height: 250,
                          width: 250,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.white.withOpacity(.5),
                  ),
                  child: Text(
                    '#${poke.id.toString().padLeft(3, "0")}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  poke.name,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: poke.types
                      .map(
                        (type) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Chip(
                            backgroundColor:
                                pokeTypeColors[type] ?? Colors.grey,
                            label: Text(
                              type,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (pokeTypeColors[type] ?? Colors.grey)
                                            .computeLuminance() >
                                        0.5
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
