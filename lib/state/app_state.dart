import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/quest.dart';
import '../core/constants/assets.dart';

class AppState extends ChangeNotifier {
  int _gold = 100;
  
  final List<Item> _inventory = List.generate(
    6,
    (_) => Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
  );

  final List<Quest> _quests = [
    Quest(title: 'Slay 10 Goblins'),
    Quest(title: 'Find the Lost Ring'),
    Quest(title: 'Craft a Flame Sword'),
    Quest(title: 'Visit the Tavern'),
    Quest(title: 'Level up to 5'),
  ];

  final List<Item> _shopItems = [];

  // Master shop items organized by quest count required (0, 2, 5)
  final Map<int, List<Item>> _masterShopItems = {
    0: [
      Item(name: 'Rusty Sword', description: 'An old, rusty blade.', price: 50, imagePath: AppAssets.sword),
    ],
    2: [
      Item(name: 'Iron Armor', description: 'Stronger iron protection.', price: 150, imagePath: AppAssets.armor),
      Item(name: 'Steel Sword', description: 'A sharp steel blade.', price: 100, imagePath: AppAssets.sword),
    ],
    5: [
      Item(name: 'Dragon Armor', description: 'Armor made from dragon scales.', price: 500, imagePath: AppAssets.armor, isLegendary: true),
      Item(name: 'Excalibur', description: 'A legendary sword.', price: 1000, imagePath: AppAssets.sword, isLegendary: true),
    ],
  };

  AppState() {
    updateShopStock();
  }

  // Getters
  int get gold => _gold;
  List<Item> get inventory => List.unmodifiable(_inventory);
  List<Quest> get quests => List.unmodifiable(_quests);
  List<Item> get shopItems => List.unmodifiable(_shopItems);

  // Actions
  void toggleQuest(int index) {
    if (index < 0 || index >= _quests.length) return;
    
    final quest = _quests[index];
    quest.isCompleted = !quest.isCompleted;
    
    if (quest.isCompleted) {
      _gold += 50;
      _rechargePotion();
    } else {
      _gold -= 50;
    }
    
    updateShopStock();
    notifyListeners();
  }

  void buyItem(int index) {
    if (index < 0 || index >= _shopItems.length) return;
    
    final item = _shopItems[index];
    if (_gold >= item.price) {
      final emptyIndex = _inventory.indexWhere((invItem) => invItem.isEmpty);
      if (emptyIndex != -1) {
        _gold -= item.price.toInt();
        _inventory[emptyIndex] = item;
        _shopItems.removeAt(index);
        notifyListeners();
      }
    }
  }

  void updateShopStock() {
    final completedCount = _quests.where((q) => q.isCompleted).length;
    
    // Keep existing Health Potions to ensure they are treated separately from unique items
    final List<Item> currentPotions = _shopItems.where((item) => item.name == 'Health Potion').toList();
    _shopItems.clear();
    _shopItems.addAll(currentPotions);
    
    _masterShopItems.forEach((tier, items) {
      if (completedCount >= tier) {
        for (var item in items) {
          final isAlreadyOwned = _inventory.any((invItem) => invItem.name == item.name);
          final isAlreadyInShop = _shopItems.any((shopItem) => shopItem.name == item.name);
          if (!isAlreadyOwned && !isAlreadyInShop) {
            _shopItems.add(item);
          }
        }
      }
    });

    // Ensure initial stock or recharge up to 3 potions
    int potionCount = _shopItems.where((item) => item.name == 'Health Potion').length;
    while (potionCount < 3) {
      _shopItems.add(Item(
        name: 'Health Potion',
        description: 'Restores small amount of health.',
        price: 20,
        imagePath: AppAssets.potion,
      ));
      potionCount++;
    }
  }

  void _rechargePotion() {
    final potionCount = _shopItems.where((item) => item.name == 'Health Potion').length;
    if (potionCount < 3) {
      _shopItems.add(Item(
        name: 'Health Potion',
        description: 'Restores small amount of health.',
        price: 20,
        imagePath: AppAssets.potion,
      ));
    }
  }

  void deleteItem(int index) {
    if (index < 0 || index >= _inventory.length) return;
    _inventory[index] = Item(name: 'Empty Slot', description: '', price: 0, imagePath: '');
    updateShopStock();
    notifyListeners();
  }

  void toggleFavorite(int index) {
    if (index < 0 || index >= _inventory.length) return;
    _inventory[index].isFavorite = !_inventory[index].isFavorite;
    notifyListeners();
  }

  void resetQuests() {
    for (var quest in _quests) {
      quest.isCompleted = false;
    }
    _gold = 100;
    updateShopStock();
    notifyListeners();
  }
}
