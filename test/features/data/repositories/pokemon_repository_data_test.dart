import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_data_source.dart';
import 'package:poke_dex/features/data/repositories/pokemon_repository_data.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

import 'pokemon_repository_data_test.mocks.dart';

@GenerateMocks([PokemonDataSource])
void main() {
  final pokemonDataSourceMock = MockPokemonDataSource();

  final pokemonRepository = PokemonRepositoryData(pokemonDataSourceMock);

  group('PokemonRepositoryData group', () {
    test('should return a pokemon list', () async {
      when(pokemonDataSourceMock.fetchPokemonList()).thenAnswer(
        (_) => Future.value(PokemonFakeData.pokeList),
      );

      var result = await pokemonRepository.fetchPokemonList();

      expect(result.isRight(), true);

      verify(pokemonDataSourceMock.fetchPokemonList()).called(1);

      result.fold(
        (l) => expect(l, null),
        (r) => expect(r, PokemonFakeData.pokeList),
      );
    });
  });
}
