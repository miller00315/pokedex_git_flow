import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/data/models/specie.dart';

abstract class IPokemonV2DataSource {
  Future<PokemonDetailModel> fetchPokemonDetails(String name);
  Future<SpecieModel> fetchSpecie(String number);
}

class PokemonV2DataSource implements IPokemonV2DataSource {
  Client client = Client();

  PokemonV2DataSource({Client? clientParam}) : client = clientParam ?? Client();

  @override
  Future<PokemonDetailModel> fetchPokemonDetails(String name) async {
    final res = await client.get(
      Uri.https(
        "pokeapi.co",
        '/api/v2/pokemon/$name',
      ),
    );

    return PokemonDetailModel.fromJson(jsonDecode(res.body));
  }

  @override
  Future<SpecieModel> fetchSpecie(String number) async {
    final res = await client.get(
      Uri.https(
        'pokeapi.co',
        'api/v2/pokemon-species/$number',
      ),
    );

    return SpecieModel.fromJson(jsonDecode(res.body));
  }
}
