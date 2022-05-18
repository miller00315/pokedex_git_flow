import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:poke_dex/features/data/services/pokemon_service.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

void main() {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');

  final data = encoder.convert(PokemonFakeData.pokeList.toJson());

  final client = MockClient(
    (request) async => Response(data, 200),
  );
  group('PokemonService group', () {
    test('Testing network call', () async {
      final pokemonService = PokemonService(client: client);

      final res = await pokemonService.fetchPokemonList();

      expect(res.body, data);
    });
  });
}
