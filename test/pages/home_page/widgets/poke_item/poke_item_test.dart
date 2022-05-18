import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_store.dart';
import 'package:poke_dex/features/presentation/widgets/layout/poke_item_types.dart';

import '../../../../stores/pokemon/pokemon_store_test.mocks.dart';

void main() {
  final pokemonRepositoryMock = MockPokemonRepositoryMock();
  final secureStorageRepositoryMock = MockSecureStorageRepositoryMock();

  final PokemonStore pokemonStore =
      PokemonStore(pokemonRepositoryMock, secureStorageRepositoryMock);

  final pokemon = PokemonFakeData.pokemonList.first;
  group('PokeItem group', () {
    Widget createWidgetForTesting() => MaterialApp(
          home: Material(
            child: PokeItem(
              pokemon: pokemon,
              index: 0,
              pokemonStore: pokemonStore,
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

    testWidgets('should render a PokeItem widget with favorite icons',
        (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          pokemonStore.favorites = [pokemon.id!].asObservable();

          await tester.pumpWidget(createWidgetForTesting());

          expect(
            find.text(pokemon.name!),
            findsOneWidget,
          );

          expect(find.byType(Icon), findsOneWidget);
        },
      );
    });
  });
}
