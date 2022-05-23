import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:poke_dex/features/presentation/app.dart';
import 'package:poke_dex/features/presentation/pages/details_page/details_page.dart';
import 'package:poke_dex/features/presentation/pages/home_page/home_page.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';

import 'package:poke_dex/injector/main.dart' as injector;

main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final serviceLocator = GetIt.instance;

  setUp(() async {
    await injector.init(
      repositoryInjector: injector.RepositoryInjector.useApi,
    );
  });

  tearDown(() {
    serviceLocator.pushNewScope();
  });

  group('App group E2E test', () {
    testWidgets('should render app and show PokeItem widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      await tester.pumpAndSettle();

      expect(
        find.byType(PokeItem),
        findsWidgets,
      );

      expect(
        find.byType(HomePage),
        findsOneWidget,
      );

      expect(
        find.byType(DetailsPage),
        findsNothing,
      );
    });

    testWidgets('should render app and when tap pokeItem open another screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      await tester.pumpAndSettle();

      final pokeItems = find.byType(PokeItem);

      expect(
        find.byType(PokeItem),
        findsWidgets,
      );

      await tester.tap(pokeItems.first);

      await tester.pumpAndSettle();

      expect(
        find.byType(DetailsPage),
        findsOneWidget,
      );

      expect(
        find.byType(HomePage),
        findsNothing,
      );

      expect(
        find.byType(Tab),
        findsNWidgets(3),
      );
    });
  });
}
