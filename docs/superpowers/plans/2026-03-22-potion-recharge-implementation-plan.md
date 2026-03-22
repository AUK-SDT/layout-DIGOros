# Potion Recharge System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a dynamic "Potion Restock" system where the merchant replenishes Health Potions after each quest completion, up to a maximum of 3.

**Architecture:** `AppState` logic is updated to handle multi-buyable "Health Potions" as a special case in the shop stocking logic.

**Tech Stack:** Flutter SDK, `provider` package.

---

### Task 1: Update State Logic (AppState)
**Files:**
- Modify: `lib/state/app_state.dart`

- [ ] **Step 1: Update `updateShopStock()` for Initial Stock**
    - Modify the stocking logic to ensure that if "Health Potion" count is less than 3, it adds up to 3 potions to `_shopItems`.
- [ ] **Step 2: Create `_rechargePotion()` Method**
    - Count current "Health Potion" instances in `_shopItems`.
    - If count < 3, add one new `Item` (Health Potion) to `_shopItems`.
- [ ] **Step 3: Update `toggleQuest()` Trigger**
    - In `toggleQuest()`, call `_rechargePotion()` only if `quest.isCompleted` is **true** after the toggle.
- [ ] **Step 4: Commit changes**
    - `git add lib/state/app_state.dart`
    - `git commit -m "feat: implement potion recharge logic in AppState"`

---

### Task 2: Final Verification
- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Manual Check**
    - Buy all 3 potions from the Merchant.
    - Go to Quests and complete one quest.
    - Return to Merchant: One potion should be back in stock.
    - Complete two more quests: Shop should have 3 potions.
    - Complete a fourth quest: Shop should STILL have only 3 potions (no stacking).
- [ ] **Step 3: Commit final updates**
    - `git add .`
    - `git commit -m "refactor: verify potion recharge integration and clean up"`
