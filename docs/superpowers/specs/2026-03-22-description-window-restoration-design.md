# Design Specification: Description Window Restoration

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Restore the interactive "Item Description" dialogs in both the Inventory and Shop screens while ensuring they are stable and do not conflict with other buttons.

---

## 1. Inventory Screen: Hit-Test Fixing
The current `IconButton` widgets for "Favorite" and "Delete" are placed on top of the `InkWell`, which can sometimes block the `onTap` event for the description dialog.

### UI Changes:
- **Button Isolation**: Wrap the "Favorite" and "Delete" icons in a way that allows them to be tapped without canceling the main card's `InkWell` tap if the user misses the small icon area.
- **Dialog Call**: Ensure `_showItemDetails` is called consistently on card tap.
- **Stability**: Wrap the `AlertDialog` content in a `SingleChildScrollView` to prevent "Missing Size" errors on small screens.

---

## 2. Shop Screen: Merchant's Detail Dialog
The "Merchant's Ledger" currently shows a short description in the row but lacks a full detail view. We will re-add this for a professional feel.

### UI Changes:
- **Row Interaction**: Wrap the non-button part of the `_ShopListItem` row in an `InkWell` or `GestureDetector`.
- **New Dialog**: Implement `_showShopItemDetails(context, item)` that displays:
    - High-quality item image.
    - Full description.
    - Rarity/Legendary status.
    - Price.
- **Exclusion**: The "Buy" button remains a separate action that does not trigger the dialog.

---

## 3. Technical Stability (The "Missing Size" Fix)
To prevent the `Cannot hit test a render box with no size` error seen earlier:
1. **Explicit Constraints**: All images inside dialogs will have fixed `height` and `width: double.infinity`.
2. **Scrollable Content**: `SingleChildScrollView` will be used as the root of the `AlertDialog.content` to ensure Flutter can calculate the size even during complex layout passes.
3. **Context Safety**: Use `Navigator.of(dialogContext).pop()` to avoid shadowing issues.

---

## 4. Success Criteria
1. Tapping an Inventory item opens the description dialog.
2. Tapping a Shop item (except the Buy button) opens a detail dialog.
3. Favorite and Delete buttons still work perfectly.
4. No layout crashes or "invisible window" bugs.
5. Code passes all `flutter analyze` checks.
