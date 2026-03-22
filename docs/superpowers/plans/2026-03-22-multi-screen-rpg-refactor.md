# Multi-Screen RPG Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the existing single-screen Flutter RPG app into a professional, multi-screen, feature-based application with clean state management and consistent theming.

**Architecture:** Feature-based folder structure (`core`, `features`, `models`). Navigation uses a Hub-and-Spoke model with a central `HubScreen`. State management uses `ChangeNotifier` and the `provider` package for reactivity across multiple screens.

**Tech Stack:** Flutter SDK, `provider` package, `confetti` package.

---

### Task 0: Preparation & Dependencies
**Files:**
- Modify: `pubspec.yaml`
- Create: `lib/core/`, `lib/features/`, `lib/state/`, `lib/models/` directories

- [ ] **Step 1: Add `provider` dependency**
    - Run: `flutter pub add provider`
- [ ] **Step 2: Create directory structure**
    - Run: `mkdir -p lib/core/theme lib/core/widgets lib/core/constants lib/features/hub lib/features/inventory lib/features/quests lib/state lib/models`
- [ ] **Step 3: Commit changes**
    - `git add pubspec.yaml`
    - `git commit -m "chore: add provider dependency and create folder structure"`

---

### Task 1: Core Theme & Constants
**Files:**
- Create: `lib/core/constants/assets.dart`
- Create: `lib/core/theme/app_theme.dart`

- [ ] **Step 1: Define Asset Constants**
    - Create `lib/core/constants/assets.dart` with static strings for sword, armor, and potion paths.
- [ ] **Step 2: Implement AppTheme**
    - Create `lib/core/theme/app_theme.dart` defining a `ThemeData` with a dark RPG palette (charcoal, gold, amber).
- [ ] **Step 3: Commit changes**
    - `git add lib/core/constants/assets.dart lib/core/theme/app_theme.dart`
    - `git commit -m "feat: add RPG theme and asset constants"`

---

### Task 2: State Management (AppState)
**Files:**
- Create: `lib/state/app_state.dart`
- Create: `lib/models/item.dart`
- Create: `lib/models/quest.dart`

- [ ] **Step 1: Migrate Models**
    - Move `Item`, `Quest`, and `Durability` from `lib/item.dart` to their respective new files in `lib/models/`.
- [ ] **Step 2: Implement AppState**
    - Create `lib/state/app_state.dart` as a `ChangeNotifier`. 
    - Include `gold`, `items`, and `quests` lists.
    - Add methods: `toggleQuest(Quest)`, `deleteItem(Item)`, `toggleFavorite(Item)`.
- [ ] **Step 3: Commit changes**
    - `git add lib/state/app_state.dart lib/models/item.dart lib/models/quest.dart`
    - `git commit -m "feat: implement AppState with ChangeNotifier"`

---

### Task 3: Shared UI Components
**Files:**
- Create: `lib/core/widgets/gold_display.dart`
- Create: `lib/core/widgets/rpg_card.dart`
- Create: `lib/core/widgets/app_button.dart`

- [ ] **Step 1: Implement GoldDisplay**
    - A small widget showing the gold icon and `context.watch<AppState>().gold`.
- [ ] **Step 2: Implement RPGCard**
    - A styled container for items and quests.
- [ ] **Step 3: Implement AppButton**
    - A standardized button style for all primary actions.
- [ ] **Step 4: Commit changes**
    - `git add lib/core/widgets/gold_display.dart lib/core/widgets/rpg_card.dart lib/core/widgets/app_button.dart`
    - `git commit -m "feat: add reusable RPG UI components"`

---

### Task 4: Feature: Hub Screen
**Files:**
- Create: `lib/features/hub/hub_screen.dart`

- [ ] **Step 1: Implement HubScreen**
    - Display character stats (Gold).
    - Add two large `AppButton` widgets: "Open Inventory" and "Quest Log".
    - Use `Navigator.push` for navigation.
- [ ] **Step 2: Commit changes**
    - `git add lib/features/hub/hub_screen.dart`
    - `git commit -m "feat: add central Hub screen"`

---

### Task 5: Feature: Inventory Screen
**Files:**
- Create: `lib/features/inventory/inventory_screen.dart`

- [ ] **Step 1: Implement InventoryScreen**
    - Migrate the grid logic from `main.dart`.
    - Use `context.watch<AppState>().items` to build the grid.
    - Implement the "Item Details" dialog.
- [ ] **Step 2: Commit changes**
    - `git add lib/features/inventory/inventory_screen.dart`
    - `git commit -m "feat: implement Inventory screen"`

---

### Task 6: Feature: Quests Screen
**Files:**
- Create: `lib/features/quests/quests_screen.dart`

- [ ] **Step 1: Implement QuestsScreen**
    - Migrate the quest list logic from `main.dart`.
    - Use `context.watch<AppState>().quests`.
    - Integrate the `ConfettiController` and animation.
- [ ] **Step 2: Commit changes**
    - `git add lib/features/quests/quests_screen.dart`
    - `git commit -m "feat: implement Quests screen with confetti FX"`

---

### Task 7: Final Assembly
**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Refactor main.dart**
    - Wrap `MaterialApp` in a `ChangeNotifierProvider<AppState>`.
    - Set `theme: AppTheme.darkTheme`.
    - Set `home: const HubScreen()`.
- [ ] **Step 2: Clean up**
    - Delete old `lib/item.dart` and unused code in `main.dart`.
- [ ] **Step 3: Verify**
    - Run `flutter analyze` and `flutter run`.
- [ ] **Step 4: Commit changes**
    - `git add .`
    - `git commit -m "refactor: complete multi-screen transition and cleanup"`
