import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_favorites_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/set_favorites_usecase.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_store.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

import 'pokemon_store_test.mocks.dart';

@GenerateMocks([
  FetchPokemonUseCase,
  FetchFavoritesUsecase,
  SetFavoritesUsecase,
])
main() {
  final fetchPokemonUsecase = MockFetchPokemonUseCase();
  final fetchFavoritePokemonUsecase = MockFetchFavoritesUsecase();
  final setFavoritesUsecase = MockSetFavoritesUsecase();

  final PokemonStore pokemonStore = PokemonStore(
    fetchPokemonUsecase,
    fetchFavoritePokemonUsecase,
    setFavoritesUsecase,
  );

  group('PokemonStore group', () {
    test('should set a pokelist in the store', () async {
      when(fetchPokemonUsecase(NoParams())).thenAnswer(
        (_) => Future.value(const Right(PokemonFakeData.pokeList)),
      );

      await pokemonStore.fetchPokemonList();

      verify(fetchPokemonUsecase(NoParams())).called(1);

      expect(pokemonStore.pokeList, PokemonFakeData.pokeList);
    });
  });

  /// TODO: terminar testes
}
