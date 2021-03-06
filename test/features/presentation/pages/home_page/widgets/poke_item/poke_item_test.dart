import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poke_dex/features/domain/usecases/fetch_favorites_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/set_favorites_usecase.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_store.dart';
import 'package:poke_dex/features/presentation/widgets/layout/poke_item_types.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';

import '../home_page_body_test.mocks.dart';

void main() {
  final pokemon = PokemonFakeData.pokemonList.first;

  final fetchPokemonUsecase = MockFetchPokemonUseCase();
  final fetchFavoritesUsecase = MockFetchFavoritesUsecase();
  final setFavoritesUsecase = MockSetFavoritesUsecase();

  setUp(() {
    final serviceLocator = GetIt.instance;

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

  group('PokeItem group', () {
    Widget createWidgetForTesting() => MaterialApp(
          home: Material(
            child: PokeItem(
              pokemon: pokemon,
              index: 0,
              shouldTranslate: false,
            ),
          ),
        );

    testWidgets('should render a PokeItem widget', (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(createWidgetForTesting());

          expect(
            find.text(pokemon.name!),
            findsOneWidget,
          );

          expect(find.byType(PokeItemTypes), findsOneWidget);

          for (final type in pokemon.type!) {
            expect(find.text(type), findsOneWidget);
          }

          expect(find.byType(Icon), findsNothing);
        },
      );
    });
  });
}
