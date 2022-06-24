import 'package:flutter/material.dart';
import 'package:pokeprj/pokeapi.dart';
import 'package:pokeprj/pokemon.dart';

class PokemonsNotifier extends ChangeNotifier {
  // ID, Pokemon
  final Map<int, Pokemon?> _pokeMap = {};

  Map<int, Pokemon?> get pokes => _pokeMap;

  void addPoke(Pokemon poke) {
    _pokeMap[poke.id] = poke;
    notifyListeners();
  }

    void fetchPoke(int id) async {
    _pokeMap[id] = null;
    addPoke(await fetchPokemon(id));
  }
  
    Pokemon? byId(int id) {
    if (!_pokeMap.containsKey(id)) {
      fetchPoke(id);
    }
    return _pokeMap[id];
  }
}