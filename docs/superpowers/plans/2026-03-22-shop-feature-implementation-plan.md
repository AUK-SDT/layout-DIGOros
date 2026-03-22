# RPG Shop Feature Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a dynamic "Merchant's Stall" screen with curated stock based on quest progress.

**Architecture:** New feature `lib/features/shop/` with shared state integration. Navigation uses a Hub-and-Spoke model from the `HubScreen`.

**Tech Stack:** Flutter SDK, `provider` package.

---

### Task 1: Update State & Logic (AppState)
**Files:**
- Modify: `lib/state/app_state.dart`

- [ ] **Step 1: Add Shop Data to AppState**
    - Define a `_shopItems` list in `AppState`.
    - Create a `_masterShopItems` list with different tiers based on quest count (0, 2, 5).
- [ ] **Step 2: Implement Shop Methods**
    - `void buyItem(int index)`: Checks gold, moves item, notifies listeners.
    - `void updateShopStock()`: Updates `_shopItems` based on `completedQuestsCount`.
- [ ] **Step 3: Commit changes**
    - `git add lib/state/app_state.dart`
    - `git commit -m "feat: add Shop logic to AppState"`

---

### Task 2: Implement Shop Screen
**Files:**
- Create: `lib/features/shop/shop_screen.dart`

- [ ] **Step 1: Create ShopScreen UI**
    - GridView showing current `appState.shopItems`.
    - Items display price in the card.
- [ ] **Step 2: Implement Purchase Flow**
    - Show `Confirmation Dialog` on tap.
    - Show `SnackBar` on success or "Not Enough Gold" failure.
- [ ] **Step 3: Commit changes**
    - `git add lib/features/shop/shop_screen.dart`
    - `git commit -m "feat: implement Shop screen UI"`

---

### Task 3: Hub Navigation & Integration
**Files:**
- Modify: `lib/features/hub/hub_screen.dart`

- [ ] **Step 1: Add Hub Button**
    - Add a new `AppButton` titled "Visit Merchant" in `HubScreen`.
    - Link it to `ShopScreen` via `Navigator.push()`.
- [ ] **Step 2: Commit changes**
    - `git add lib/features/hub/hub_screen.dart`
    - `git commit -m "feat: add Shop navigation to Hub"`

---

### Task 4: Final Verification
- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Manual Check**
    - Buy item -> Check gold in Hub -> Check item in Inventory.
- [ ] **Step 3: Commit final updates**
    - `git add .`
    - `git commit -m "refactor: verify shop integration and clean up"`
