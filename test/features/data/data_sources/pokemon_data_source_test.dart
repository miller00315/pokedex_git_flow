import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_data_source.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

void main() {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');

  final data = encoder.convert(PokemonFakeData.pokeList.toJson());

  final client = MockClient(
    (request) async => Response(data, 200),
  );

  group('PokemonDataSource group', () {
    test('Testing network call', () async {
      final pokemonService = PokemonDataSource(clientParam: client);

      final res = await pokemonService.fetchPokemonList();

      expect(res, PokemonFakeData.pokeList);
    });
  });
}
