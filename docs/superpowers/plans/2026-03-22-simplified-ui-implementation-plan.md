# Simplified Shop & Inventory UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the bug-prone Grid/Dialog shop with a robust, List-based "Merchant's Ledger" and clean up the Inventory grid to a more professional standard.

**Architecture:** `ShopScreen` uses a `ListView` for maximum stability. `InventoryScreen` remains a 6-slot `GridView` but with clean, empty slots (no text).

**Tech Stack:** Flutter SDK, `provider` package.

---

### Task 1: Refactor Shop Screen (The Merchant's Ledger)
**Files:**
- Modify: `lib/features/shop/shop_screen.dart`

- [ ] **Step 1: Replace GridView with ListView**
    - Implement the `ShopScreen` body as a `ListView.separated` or `ListView.builder`.
    - Each item should be displayed in an `RPGCard` row showing:
        - Small image (left).
        - Name and description (center).
        - Price and "Buy" Button (right).
- [ ] **Step 2: Implement Inline Buy Logic**
    - The "Buy" button should directly trigger the `appState.buyItem(item)` method.
    - Include capacity and gold checks with `SnackBar` notifications.
- [ ] **Step 3: Commit changes**
    - `git add lib/features/shop/shop_screen.dart`
    - `git commit -m "feat: refactor Shop to List-based UI with inline buy"`

---

### Task 2: Professionalize Inventory Grid
**Files:**
- Modify: `lib/features/inventory/inventory_screen.dart`

- [ ] **Step 1: Clean Up Empty Slot UI**
    - In `_InventoryGridItem`, remove the `Text('Empty Slot')` widget.
    - If `item.isEmpty`, return only a clean `RPGCard` with a subtle, dark color to represent the "slot background".
- [ ] **Step 2: Commit changes**
    - `git add lib/features/inventory/inventory_screen.dart`
    - `git commit -m "feat: update Inventory Grid with clean, professional empty slots"`

---

### Task 3: Final Assembly & Verification
- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Manual Check**
    - Verify Shop is a list and items can be bought with a single click.
    - Verify Inventory shows 6 slots, and empty ones are clean boxes.
    - Confirm "Missing Size" and "Hit Test" errors are gone.
- [ ] **Step 3: Commit final updates**
    - `git add .`
    - `git commit -m "refactor: verify simplified UI integration and clean up"`
