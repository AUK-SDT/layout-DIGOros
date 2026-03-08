class Item {
  Item({
    required this.description,
    required this.imagePath,
    required this.name,
    required this.price,
    this.isLegendary = false,
    this.durability,
    this.isFavorite = false,
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  final bool isLegendary;
  final Durability? durability;
  bool isFavorite;

  bool get isEmpty => imagePath.isEmpty && description.isEmpty;
}

class Quest {
  Quest({
    required this.title,
    this.isCompleted = false,
  });

  final String title;
  bool isCompleted;
}

enum Durability {
  max,
  medium,
  low;

  String get label {
    switch (this) {
      case .max:
        return 'Maximum durability';
      case .medium:
        return 'Medium durability';
      case .low:
        return 'Low durability';
    }
  }
}
