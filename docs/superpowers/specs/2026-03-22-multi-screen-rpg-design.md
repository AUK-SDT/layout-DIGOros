# Design Specification: Multi-Screen RPG Application

**Date:** 2026-03-22
**Project:** homework_4_mykhailo_kustov
**Goal:** Refactor the existing single-screen Flutter RPG app into a professional, multi-screen, feature-based application with clean state management and consistent theming.

---

## 1. High-Level Architecture
We will adopt a **Feature-Based Architecture**. This promotes code reusability, testability, and a clear separation of concerns (OOP principles).

### Folder Structure:
- `lib/core/` - Shared utilities, themes, and "Global" widgets (e.g., `GoldCounter`).
- `lib/features/hub/` - Central dashboard screen.
- `lib/features/inventory/` - Grid-based item management screen.
- `lib/features/quests/` - Quest log screen.
- `lib/models/` - Data models for `Item`, `Quest`, and `AppState`.
- `lib/state/` - State management logic (ChangeNotifier).

---

## 2. Navigation Strategy: Hub-and-Spoke
The `BottomNavigationBar` will be replaced with a **Hub-and-Spoke** model.
- **HubScreen**: The main entry point. Displays Gold and character stats. Provides large buttons to "Open Inventory" and "View Quests".
- **InventoryScreen**: Full-screen view pushed via `Navigator.push()`. Contains its own grid logic.
- **QuestsScreen**: Full-screen view pushed via `Navigator.push()`. Contains its own quest log.

*Each screen will include a professional "Back" button in the AppBar for easy navigation.*

---

## 3. State Management: Shared RPG State
To share "Gold" and "Lists" across multiple screens without "prop drilling," we will use Flutter's built-in `ChangeNotifier`.
- **AppState**: A central class that holds the `List<Item>`, `List<Quest>`, and `int gold`.
- **Automatic Updates**: When a quest is completed on the `QuestsScreen`, the `gold` counter in the `HubScreen` will automatically update.

---

## 4. Professional Theming & UI
Extract hardcoded styles into a unified **AppTheme**.
- **Dark RPG Theme**: Deep charcoal backgrounds, gold/amber accents, and "Medieval" style card borders.
- **Reusable Widgets**:
    - `RPGCard`: A custom container with standard padding and rounded corners.
    - `GoldDisplay`: A small, reusable widget showing the gold icon and amount.
    - `AppButton`: A standardized button for all primary actions.

---

## 5. Success Criteria
1. `main.dart` contains only the `MaterialApp` and app setup.
2. Navigating between Hub, Inventory, and Quests works seamlessly.
3. Updating Gold on the Quests screen reflects instantly on the Hub screen.
4. No hardcoded colors or text styles (all sourced from `ThemeData`).
5. All logic moved to separate files (models, features, state).
