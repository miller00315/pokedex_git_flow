import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_repository.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

import 'fetch_pokemon_usecase_test.mocks.dart';

@GenerateMocks([PokemonRepository])
main() {
  final pokemonRepository = MockPokemonRepository();

  group('FetchPokemonUsecase group', () {
    test('should return on right a PokeList', () async {
      when(pokemonRepository.fetchPokemonList()).thenAnswer(
        (_) => Future.value(const Right(PokemonFakeData.pokeList)),
      );

      final fetchPokemonUsecase = FetchPokemonUseCase(pokemonRepository);

      final res = await fetchPokemonUsecase(NoParams());

      expect(res.isRight(), true);

      verify(pokemonRepository.fetchPokemonList()).called(1);

      res.fold(
        (l) => expect(l, null),
        (r) => expect(r, PokemonFakeData.pokeList),
      );
    });
  });
}
