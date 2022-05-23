/* class MockFunction extends Mock {
  call({
    required PokemonModel pokemon,
    required int index,
  });
}
 */
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_dex/features/data/models/pokemon_model.dart';
import 'package:poke_dex/features/domain/usecases/fetch_favorites_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/set_favorites_usecase.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/home_page_body.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_store.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

import 'home_page_body_test.mocks.dart';

class MockFunction extends Mock {
  call({
    required PokemonModel pokemon,
    required int index,
  });
}

@GenerateMocks([
  FetchPokemonUseCase,
  FetchFavoritesUsecase,
  SetFavoritesUsecase,
])
void main() {
  final fetchPokemonUsecase = MockFetchPokemonUseCase();
  final fetchFavoritesUsecase = MockFetchFavoritesUsecase();
  final setFavoritesUsecase = MockSetFavoritesUsecase();

  final handlePokemonItemClickMock = MockFunction();

  final serviceLocator = GetIt.instance;

  setUp(() {
    serviceLocator.pushNewScope();

    serviceLocator.registerLazySingleton<IFetchFavoritesUsecase>(
      () => fetchFavoritesUsecase,
    );

    serviceLocator.registerLazySingleton<ISetFavoritesUsecase>(
      () => setFavoritesUsecase,
    );

    serviceLocator.registerLazySingleton<IFetchPokemonUseCase>(
      () => fetchPokemonUsecase,
    );

    serviceLocator.registerLazySingleton<PokemonStore>(() => PokemonStore(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ));
  });

  tearDown(() {
    serviceLocator.pushNewScope();
  });

  group('HomePageBody group', () {
    Widget createWidgetForTesting(List<PokemonModel> pokemons) => MaterialApp(
          home: Material(
            child: HomePageBody(
              handlePokemonItemClicked: handlePokemonItemClickMock,
              pokemons: pokemons,
              shouldTranslate: false,
            ),
          ),
        );

    testWidgets('should render a HomePageBody widget',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          createWidgetForTesting(
            PokemonFakeData.pokeList.pokemonList!,
          ),
        );

        expect(
          find.byType(PokeItem),
          findsNWidgets(2),
        );

        for (var index = 0;
            index < PokemonFakeData.pokeList.pokemonList!.length;
            index++) {
          final pokeItem = find.byKey(
            Key(
              '${HomePageBody.homePagePokeItem}$index',
            ),
          );

          await tester.ensureVisible(pokeItem);

          await tester.pumpAndSettle();

          await tester.tap(pokeItem);

          verify(
            handlePokemonItemClickMock(
              pokemon: PokemonFakeData.pokeList.pokemonList![index],
              index: index,
            ),
          ).called(1);
        }
      });
    });
  });
}
