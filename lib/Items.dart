class Items {
  const Items({
    required this.description,
    required this.imagePath,
    required this.name,
    required this.price,
    this.isLegendary = false,
    this.durability,
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  final bool isLegendary;
  final Durability? durability;
}

enum Durability {
  max,
  medium,
  low;

  String get label {
    switch (this) {
      case Durability.max:
        return 'Maximum durability';
      case Durability.medium:
        return 'Medium durability';
      case Durability.low:
        return 'Low durability';
    }
  }
}
