import 'dart:convert';

import 'package:pokeprj/consts/pokeapi.dart';
import 'package:pokeprj/pokemon.dart';
import 'package:http/http.dart' as http;


Future<Pokemon> fetchPokemon(int id) async {
  final res = await http.get(Uri.parse('$pokeApiRoute/pokemon/$id'));
  if (res.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}
