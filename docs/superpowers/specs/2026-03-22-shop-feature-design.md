# Design Specification: RPG Shop Feature

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Add a dynamic "Merchant's Stall" (Shop) screen that interacts with the player's gold, inventory, and quest progress.

---

## 1. High-Level Architecture
The Shop will be implemented as a new feature: `lib/features/shop/`. It will integrate with the existing `AppState` and `models/`.

### Folder Structure:
- `lib/features/shop/`
    - `shop_screen.dart` - Grid-based shop UI.
    - `widgets/shop_item_card.dart` - Individual item display for the shop.

---

## 2. Shop Logic: Curated Progress
The shop's stock will be determined by the number of completed quests (`Option C`).
- **Initial Stock**: Basic items (e.g., "Wooden Shield", "Healing Potion").
- **Level 2 Stock**: Appears after 2 quests (e.g., "Steel Sword", "Iron Armor").
- **Level 3 Stock**: Appears after 5 quests (e.g., "Mage Robe", "Mystic Wand").

### Purchase Logic (Option B):
1. User taps an item in the Shop.
2. A **Confirmation Dialog** appears: "Buy [Item] for [Price] Gold?"
3. If user accepts and has enough gold:
    - Gold is deducted from `AppState.gold`.
    - Item is added to `AppState.inventory`.
    - Item is removed from `AppState.shopItems`.
    - `notifyListeners()` is called to update all screens (Hub, Inventory, Shop).

---

## 3. UI Design: The Merchant's Stall
- **Hub Navigation**: A new "Visit Merchant" button will be added to the `HubScreen`.
- **Shop Screen**: 
    - A 2xN grid similar to the Inventory.
    - Uses `RPGCard` for a consistent look.
    - Displays the price clearly on each item.
- **Visual Feedback**:
    - "Not Enough Gold!" SnackBar if a purchase fails.
    - "Item Purchased!" SnackBar with a success sound/effect (optional).

---

## 4. State Management Updates
We will add the following to `AppState`:
- `List<Item> _shopItems`: The current items available for purchase.
- `void buyItem(Item item)`: Logic for checking gold, deducting it, and updating both lists.
- `void refreshShopStock()`: Logic to update `_shopItems` based on `quests.where((q) => q.isCompleted).length`.

---

## 5. Success Criteria
1. The Hub Screen has a working "Visit Merchant" button.
2. The Shop Screen displays items appropriate for the current quest progress.
3. Purchasing an item correctly deducts gold and moves the item to the Inventory.
4. If the player doesn't have enough gold, the purchase is denied with a message.
5. All screens (Hub, Inventory, Shop) stay perfectly in sync when a purchase happens.
6. Code passes `flutter analyze` with no issues.
