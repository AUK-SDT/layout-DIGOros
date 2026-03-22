# Description Window Restoration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore the interactive "Item Description" dialogs in both the Inventory and Shop screens while ensuring they are stable and do not conflict with other buttons.

**Architecture:** Update UI logic in `InventoryScreen` and `ShopScreen` to ensure proper hit-testing and stable `AlertDialog` rendering.

**Tech Stack:** Flutter SDK, `provider` package.

---

### Task 1: Fix Inventory Hit-Testing & Stabilize Dialog
**Files:**
- Modify: `lib/features/inventory/inventory_screen.dart`

- [ ] **Step 1: Update `_InventoryGridItem` Hit-Testing**
    - Ensure the `InkWell` properly wraps the card's content without being blocked by `IconButton` widgets.
- [ ] **Step 2: Fix `_showItemDetails` Content**
    - Wrap the `AlertDialog` content in a `SingleChildScrollView`.
    - Provide explicit `height` and `width: double.infinity` for images.
- [ ] **Step 3: Commit changes**
    - `git add lib/features/inventory/inventory_screen.dart`
    - `git commit -m "feat: fix inventory hit-testing and stabilize dialog"`

---

### Task 2: Restore Shop Detail Dialog
**Files:**
- Modify: `lib/features/shop/shop_screen.dart`

- [ ] **Step 1: Add Interaction to `_ShopListItem`**
    - Wrap the non-button portion of the shop row (image and text) in an `InkWell` or `GestureDetector`.
- [ ] **Step 2: Implement `_showShopItemDetails()`**
    - Create a professional detail dialog showing the full item description, rarity, and price.
    - Ensure the "Buy" button does NOT trigger the dialog.
- [ ] **Step 3: Fix Dialog Stability**
    - Use `SingleChildScrollView` and explicit constraints for images in the new dialog.
- [ ] **Step 4: Commit changes**
    - `git add lib/features/shop/shop_screen.dart`
    - `git commit -m "feat: restore shop item detail dialog"`

---

### Task 3: Final Verification
- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Manual Check**
    - Verify tapping an inventory item (not a button) opens the dialog.
    - Verify tapping a shop row (not the buy button) opens the dialog.
    - Verify favorite and delete buttons still function as expected.
    - Confirm "Missing Size" and "Hit Test" errors are gone.
- [ ] **Step 3: Commit final updates**
    - `git add .`
    - `git commit -m "refactor: verify restoration of description windows and clean up"`
