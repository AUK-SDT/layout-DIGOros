# Design Specification: Simplified Shop & Inventory UI

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Replace the bug-prone Grid/Dialog shop system with a robust, List-based "Merchant's Ledger" and clean up the Inventory grid.

---

## 1. Simplified Shop: The Merchant's Ledger
To eliminate "Missing Size" and "Hit Test" errors associated with Dialogs and Grids, we will switch to a **ListView** with **Inline Buy Buttons**.

### UI Changes:
- **No Dialogs**: Tapping an item no longer opens a pop-up.
- **List Layout**: Each item is a row showing:
    - Item Image (Small).
    - Item Name & Description.
    - Price (with Gold icon).
    - **Buy Button**: A small `AppButton` or `ElevatedButton` directly on the row.
- **Feedback**: Success/Failure SnackBar still appears as usual.

---

## 2. Professional Inventory Grid
Clean up the 6-slot inventory to look more like a professional game.
- **Empty Slots**: Replace the "Empty Slot" text with a clean, dark, empty box using the `RPGCard` background.
- **Consistency**: Hover and Border effects remain for filled slots, but empty slots stay subtle.

---

## 3. Technical Benefits
- **Stability**: `ListView` is the most stable scrolling widget in Flutter and avoids complex Grid calculations.
- **Reliability**: Removing `showDialog` eliminates the `BuildContext` shadowing and "Missing Size" crashes reported by the user.
- **Speed**: Players can buy multiple items (like 3 potions) without opening and closing dialogs.

---

## 4. Success Criteria
1. Shop items are displayed in a clean list.
2. Buying an item is a single-click action (no pop-up).
3. Inventory always shows 6 slots, with empty slots appearing as clean boxes.
4. "Inventory Full" and "Not Enough Gold" checks remain active.
5. All `flutter analyze` checks pass with zero issues.
