import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/quest.dart';
import '../core/constants/assets.dart';

class AppState extends ChangeNotifier {
  int _gold = 100;
  
  final List<Item> _inventory = [
    Item(
      name: 'Flame Sword',
      description: 'A balanced steel blade. It`s blade set ablaze with holy flames.',
      price: 120,
      imagePath: AppAssets.sword,
      durability: Durability.max,
      isLegendary: true,
    ),
    Item(
      name: 'Paladin Plate Armor',
      description: 'Heavy armor that greatly increases defense with divine protection.',
      price: 350,
      imagePath: AppAssets.armor,
      durability: Durability.medium,
      isLegendary: true,
    ),
    Item(
      name: 'Health Potion',
      description: 'Restores 50 HP instantly.',
      price: 60,
      imagePath: AppAssets.potion,
    ),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
  ];

  final List<Quest> _quests = [
    Quest(title: 'Slay 10 Goblins'),
    Quest(title: 'Find the Lost Ring'),
    Quest(title: 'Craft a Flame Sword'),
    Quest(title: 'Visit the Tavern'),
    Quest(title: 'Level up to 5'),
  ];

  // Getters
  int get gold => _gold;
  List<Item> get inventory => List.unmodifiable(_inventory);
  List<Quest> get quests => List.unmodifiable(_quests);

  // Actions
  void toggleQuest(int index) {
    if (index < 0 || index >= _quests.length) return;
    
    final quest = _quests[index];
    quest.isCompleted = !quest.isCompleted;
    
    if (quest.isCompleted) {
      _gold += 50;
    } else {
      _gold -= 50;
    }
    
    notifyListeners();
  }

  void deleteItem(int index) {
    if (index < 0 || index >= _inventory.length) return;
    _inventory.removeAt(index);
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
    notifyListeners();
  }
}
