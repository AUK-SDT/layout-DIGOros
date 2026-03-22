# Design Specification: Potion Recharge System

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Implement a dynamic "Potion Restock" system where the merchant replenishes Health Potions after each quest completion, up to a maximum of 3.

---

## 1. High-Level Architecture
We will update the `AppState` logic to handle "Health Potion" as a special, multi-buyable item in the Merchant's Stall.

### Restocking Rules:
- **Maximum Stock**: The shop will never have more than **3** "Health Potions" at once.
- **Recharge Trigger**: Every time a quest is successfully completed (`isCompleted` becomes true), **1** potion is added to the shop's stock if the current count is less than 3.
- **No Stacking**: Completing a quest only recharges up to the 3-item limit; it does not "stack" or add extra potions beyond that.
- **Initial State**: The shop starts with 3 "Health Potions" available.

---

## 2. Logic Implementation (AppState)
### updateShopStock() Update:
The logic for "Health Potion" will be separated from the "Unique Item" logic.
1. **Unique Items**: These (Swords, Armor) still only appear once and are hidden if owned.
2. **Health Potions**: 
   - Count current potions in `_shopItems`.
   - If count < 3, add `(3 - count)` potions initially, or `1` potion during a recharge trigger.

### rechargePotion() Method:
A new internal method called by `toggleQuest()` when a quest is completed:
```dart
void _rechargePotion() {
  int currentPotionCount = _shopItems.where((item) => item.name == 'Health Potion').length;
  if (currentPotionCount < 3) {
    _shopItems.add(Item(
      name: 'Health Potion', 
      description: 'Restores 50 HP instantly.', 
      price: 60, 
      imagePath: AppAssets.potion
    ));
    notifyListeners();
  }
}
```

---

## 3. UI Interactions
- **Shop Screen**: Multiple "Health Potion" cards will appear in the grid if more than one is in stock.
- **Purchase**: Buying one potion removes exactly one card from the shop and adds it to the player's 6-slot inventory.

---

## 4. Success Criteria
1. Merchant starts with 3 Health Potions.
2. Buying a potion reduces shop stock.
3. Completing a quest adds 1 potion back to the shop (if < 3).
4. Un-completing a quest does NOT remove a potion (only recharges on success).
5. Shop stock never exceeds 3 potions.
6. Logic handles the 6-slot inventory limit correctly (cannot buy if full).
