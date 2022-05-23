import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:poke_dex/features/presentation/pages/details_page/details_page.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';
import "package:poke_dex/main.dart" as app;

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App group E2E test', () {
    testWidgets('should render app and show PokeItem widgets',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(
        find.byType(PokeItem),
        findsWidgets,
      );
    });

    testWidgets('should render app and when tap pokeItem open another screen',
        (WidgetTester tester) async {
      app.main();

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
        find.byType(Tab),
        findsNWidgets(3),
      );
    });
  });
}
