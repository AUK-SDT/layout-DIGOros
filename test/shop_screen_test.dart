import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:homework_4_mykhailo_kustov/state/app_state.dart';
import 'package:homework_4_mykhailo_kustov/features/shop/shop_screen.dart';
import 'package:homework_4_mykhailo_kustov/core/widgets/gold_display.dart';
import 'package:homework_4_mykhailo_kustov/core/widgets/rpg_card.dart';

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

    expect(find.text('Adventurer\'s Shop'), findsOneWidget);
    expect(find.byType(GoldDisplay), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    
    // Check if some items from the master list are present (e.g., "Basic Potion")
    // Initially at tier 0, Basic Potion and Rusty Sword should be there.
    expect(find.text('Basic Potion'), findsOneWidget);
    expect(find.text('Rusty Sword'), findsOneWidget);
  });

  testWidgets('Tapping on item shows purchase confirmation dialog', (WidgetTester tester) async {
    await tester.pumpWidget(createShopScreen());

    // Tap on Basic Potion
    await tester.tap(find.text('Basic Potion'));
    await tester.pump(); // Start animation
    await tester.pump(const Duration(milliseconds: 500)); // Wait for dialog

    expect(find.text('Purchase Basic Potion?'), findsOneWidget);
    expect(find.text('Buy'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Purchase item with enough gold shows success SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(createShopScreen());

    // Basic Potion price is 20, initial gold is 100
    await tester.tap(find.text('Basic Potion'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Buy'));
    await tester.pumpAndSettle();

    expect(find.text('Successfully purchased Basic Potion!'), findsOneWidget);
    expect(appState.gold, equals(80));
    // Item should be removed from shop
    expect(find.text('Basic Potion'), findsNothing);
  });

  testWidgets('Purchase item without enough gold shows failure SnackBar', (WidgetTester tester) async {
    // Reset gold to something small
    appState.resetQuests(); // 100 gold
    // Rusty Sword price is 50. Let's make gold 10.
    // Actually, I can't easily set gold because it's private.
    // But I can complete/uncomplete quests to change gold.
    // Or just check if I can buy Iron Armor (price 150) with 100 gold.
    // First, complete 2 quests to unlock Iron Armor.
    appState.toggleQuest(0); // +50 = 150 gold
    appState.toggleQuest(1); // +50 = 200 gold
    // But then I will have 200 gold.
    // Let's buy something expensive first or just use an item that's more expensive than 200 gold.
    // Dragon Armor is 500 gold.
    // Let's complete all quests.
    for (int i = 0; i < 5; i++) {
      if (!appState.quests[i].isCompleted) appState.toggleQuest(i);
    }
    // 100 + 5*50 = 350 gold.
    // Dragon Armor is 500 gold.
    
    await tester.pumpWidget(createShopScreen());
    
    expect(find.text('Dragon Armor'), findsOneWidget);
    await tester.tap(find.text('Dragon Armor'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Buy'));
    await tester.pumpAndSettle();

    expect(find.text('Not enough gold to buy this item!'), findsOneWidget);
    expect(appState.gold, equals(350));
    // Item should still be in shop
    expect(find.text('Dragon Armor'), findsOneWidget);
  });
}
