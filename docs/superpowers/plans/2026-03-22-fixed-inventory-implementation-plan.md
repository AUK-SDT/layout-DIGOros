# Fixed Inventory (6 Slots) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a classic 6-slot RPG inventory where items replace empty slots and deleting an item creates an empty slot.

**Architecture:** `AppState` manages a fixed-size `List<Item>` of 6 elements. `ShopScreen` includes a capacity check before purchase.

**Tech Stack:** Flutter SDK, `provider` package.

---

### Task 1: Update AppState Logic
**Files:**
- Modify: `lib/state/app_state.dart`

- [ ] **Step 1: Initialize 6 Empty Slots**
    - Clear initial starting items ('Flame Sword', etc.).
    - Initialize `_inventory` as: `List.generate(6, (_) => Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''))`.
- [ ] **Step 2: Update `buyItem` Logic**
    - Find the first index where `item.isEmpty`.
    - If found, replace that item with the shop item.
    - If not found, skip (protection layer).
- [ ] **Step 3: Update `deleteItem` Logic**
    - Instead of `removeAt(index)`, use `_inventory[index] = Item(name: 'Empty Slot', description: '', price: 0, imagePath: '')`.
    - Call `updateShopStock()` after the deletion.
- [ ] **Step 4: Commit changes**
    - `git add lib/state/app_state.dart`
    - `git commit -m "feat: implement 6-slot fixed inventory logic in AppState"`

---

### Task 2: Update Shop UI & Checks
**Files:**
- Modify: `lib/features/shop/shop_screen.dart`

- [ ] **Step 1: Add Capacity Check**
    - Before showing the confirmation dialog in `ShopScreen`, check if `appState.inventory.any((i) => i.isEmpty)`.
    - If no empty slots exist, show a `SnackBar` with "Inventory Full! Please sell or delete something first." and return.
- [ ] **Step 2: Commit changes**
    - `git add lib/features/shop/shop_screen.dart`
    - `git commit -m "feat: add inventory capacity check to ShopScreen UI"`

---

### Task 3: Final Verification
- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Manual Check**
    - Start app -> Inventory shows 6 "Empty Slots".
    - Buy 6 items -> Hub Gold deducted, Shop items disappear.
    - Try to buy 7th item -> "Inventory Full" SnackBar appears.
    - Delete item -> Slot returns to "Empty Slot", item reappears in Merchant Stall.
- [ ] **Step 3: Commit final updates**
    - `git add .`
    - `git commit -m "refactor: verify fixed inventory integration and clean up"`
