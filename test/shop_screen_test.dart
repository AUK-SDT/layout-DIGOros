import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:homework_4_mykhailo_kustov/state/app_state.dart';
import 'package:homework_4_mykhailo_kustov/features/shop/shop_screen.dart';
import 'package:homework_4_mykhailo_kustov/core/widgets/gold_display.dart';

void main() {
  late AppState appState;

  setUp(() {
    appState = AppState();
  });

  Widget createShopScreen() {
    return ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: const MaterialApp(
        home: ShopScreen(),
      ),
    );
  }

  testWidgets('Shop screen shows items and gold', (WidgetTester tester) async {
    await tester.pumpWidget(createShopScreen());

    expect(find.text('The Merchant\'s Ledger'), findsOneWidget);
    expect(find.byType(GoldDisplay), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    
    // Check if some items from the master list are present
    expect(find.text('Health Potion'), findsWidgets);
    expect(find.text('Rusty Sword'), findsOneWidget);
  });

  testWidgets('Tapping on Buy button purchases item directly', (WidgetTester tester) async {
    await tester.pumpWidget(createShopScreen());

    // Buy Health Potion
    await tester.tap(find.text('Buy').first);
    await tester.pumpAndSettle();

    expect(find.text('Successfully purchased Health Potion!'), findsOneWidget);
    expect(appState.gold, equals(80));
  });

  testWidgets('Purchase item without enough gold shows failure SnackBar', (WidgetTester tester) async {
    // Complete all quests to unlock Dragon Armor
    for (int i = 0; i < 5; i++) {
      if (!appState.quests[i].isCompleted) appState.toggleQuest(i);
    }
    // 100 + 5*50 = 350 gold.
    // Dragon Armor is 500 gold.
    
    await tester.pumpWidget(createShopScreen());
    
    expect(find.text('Dragon Armor'), findsOneWidget);
    
    // Find the 'Buy' button for Dragon Armor
    // Since it's a list, it should be the last one if Dragon Armor is last
    // Or we can find by scrolling or just finding the one next to the text
    await tester.scrollUntilVisible(find.text('Dragon Armor'), 100);
    
    // Find Buy button in the same row as Dragon Armor
    final dragonArmorRow = find.ancestor(of: find.text('Dragon Armor'), matching: find.byType(Row));
    final buyButton = find.descendant(of: dragonArmorRow, matching: find.text('Buy'));
    
    await tester.tap(buyButton);
    await tester.pumpAndSettle();

    expect(find.text('Not enough gold to buy this item!'), findsOneWidget);
    expect(appState.gold, equals(350));
  });
}
