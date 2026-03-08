# Homework 4: Interactive RPG Inventory & Quests

This document outlines the refactor and new features implemented to transform the static inventory viewer into an interactive game prototype.

## 1. Architectural Shift: StatefulWidget Refactor
The project was migrated from a static `StatelessWidget` architecture to a dynamic `StatefulWidget` system to support real-time UI updates.

*   **`InventoryPage` (Stateful):** Now manages the global state of the application, including the active tab, player gold, and the data lists for items and quests.
*   **`_InventoryBag` (Stateful):** Handles local UI states such as hover animations and interaction feedback without requiring a full-page rebuild.

## 2. New State Management Features
I implemented a robust state system using `setState()` to handle user interactions:

*   **Gold Economy:** A dynamic `_gold` variable tracks player currency. Gold is earned by completing quests and updated instantly in the `AppBar`.
*   **Tab Switching:** A `_selectedIndex` state controls the `BottomNavigationBar`, allowing users to swap between the **Inventory** and **Quests** views.
*   **Dynamic Data Lists:** Items and Quests are no longer static constants. They are mutable lists stored in `State`, allowing for real-time deletion and status updates.

## 3. Interactive UI Components
Several new interactive elements were added to meet the hometask requirements:

*   **Bottom Navigation Bar:** Enables seamless switching between different game sections.
*   **Quest Tracker (TO-DO Style):**
    *   **Functionality:** Uses `CheckboxListTile` to allow players to complete objectives.
    *   **Visual Feedback:** Completed quests trigger a `TextDecoration.lineThrough` effect and change color to grey.
*   **Item Management:**
    *   **Like/Favorite:** A toggleable heart icon on each item allows users to mark specific gear as favorites.
    *   **Deletion:** A trash icon allows players to surgically remove items from their inventory grid.
*   **Hover & Touch Feedback:** Slots now use an `AnimatedContainer` that changes its border color smoothly when hovered or tapped.
*   **SnackBars:** Contextual pop-up notifications confirm when a player has earned rewards (e.g., "+50 Gold!").

## 4. Third-Party Package Integration: `confetti`
To satisfy the requirement of using a package from [pub.dev](https://pub.dev), I integrated the **`confetti`** package.

*   **General Purpose:** Provides high-performance particle animations to celebrate user achievements.
*   **Project Usage:** 
    *   A `ConfettiController` is managed within the `initState` and `dispose` lifecycle methods.
    *   **The Trigger:** The confetti "blasts" specifically when a quest is marked as completed.
    *   **Customization:** I implemented a custom `_drawStar` helper method to generate **magical star-shaped particles**, perfectly aligning with the RPG fantasy aesthetic.

## 5. Data Model Enhancements (`lib/item.dart`)
*   **`Quest` Class:** Created a new model to track titles and completion status.
*   **`Item` Update:** Added an `isFavorite` boolean property to support the new "Like" functionality.

---
**Note:** To run this project, please execute `flutter pub get` to install the newly added `confetti` dependency.
