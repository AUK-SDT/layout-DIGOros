# Design Specification: Fixed Inventory Logic (6 Slots)

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Implement a classic RPG "Fixed Grid" inventory system where players have exactly 6 slots to manage.

---

## 1. High-Level Architecture
We will update the `AppState` to manage a fixed-size list and the `ShopScreen` to enforce the capacity limit.

### Inventory Rules:
- **Fixed Size**: The `_inventory` list will always contain exactly 6 `Item` objects.
- **Empty Items**: An "Empty" item is defined as an `Item` with an empty `name` or `imagePath` (using `Item.isEmpty`).
- **Initial State**: On startup, the inventory is filled with 6 "Empty Slot" placeholders.

---

## 2. Inventory Management Logic
### Purchase Flow:
1. **Capacity Check**: Before showing the "Buy" dialog, the Shop checks if there is at least one `Item.isEmpty` in the inventory.
2. **Finding a Slot**: The `buyItem` method finds the index of the first empty item:
   ```dart
   int emptyIndex = _inventory.indexWhere((item) => item.isEmpty);
   ```
3. **Replacement**: The `Item` from the shop *replaces* the empty item at that index instead of being added to the end of the list.

### Deletion Flow:
1. When an item is deleted, it is not removed from the list. 
2. Instead, it is **replaced** with a new "Empty Slot" object at the same index.
3. `updateShopStock()` is called to potentially return the deleted item to the merchant's stall.

---

## 3. UI Interactions
- **Shop Screen**: If the inventory is full (no empty slots), the "Buy" button is disabled or shows a "Inventory Full!" message.
- **Inventory Screen**: The grid always shows exactly 6 slots (2x3 or 3x2), maintaining a professional and stable layout.

---

## 4. Success Criteria
1. Inventory starts with 6 empty slots.
2. Buying an item occupies one of the 6 slots.
3. Deleting an item restores an "Empty Slot" at that position.
4. Attempting to buy with 6 items results in an "Inventory Full" warning.
5. Deleting a unique item makes it reappear in the Shop (sync logic).
