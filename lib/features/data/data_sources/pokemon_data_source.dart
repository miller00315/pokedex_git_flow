import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';

abstract class IPokemonDataSource {
  Future<PokeListModel> fetchPokemonList();
}

class PokemonDataSource implements IPokemonDataSource {
  final Client client;

  PokemonDataSource({Client? clientParam}) : client = clientParam ?? Client();

  @override
  Future<PokeListModel> fetchPokemonList() async {
    final res = await client.get(
      Uri.https(
        'raw.githubusercontent.com',
        'Biuni/PokemonGO-Pokedex/master/pokedex.json',
      ),
    );

    return PokeListModel.fromJson(jsonDecode(res.body));
  }
}
