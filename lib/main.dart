import 'package:flutter/material.dart';
import 'Items.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InventoryPage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFFB98068),
      ),
    );
  }
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  static const List<Items> menu = [
    Items(
      name: 'Flame Sword',
      description:
          'A balanced steel blade. It`s blade set ablaze with holy flames.',
      price: 120,
      imagePath: 'Assets/images/Sword.png',
      durability: Durability.max,
      isLegendary: true,
    ),
    Items(
      name: 'Paladin Plate Armor',
      description:
          'Heavy armor that greatly increases defense with divine protection.',
      price: 350,
      imagePath: 'Assets/images/Armor.png',
      durability: Durability.medium,
      isLegendary: true,
    ),
    Items(
      name: 'Health Potion',
      description: 'Restores 50 HP instantly.',
      price: 60,
      imagePath: 'Assets/images/Potion.png',
    ),

    // Empty slots
    Items(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Items(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Items(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: AppBar(
        title: const Text('Your Inventory'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menu.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return _InventoryBag(items: menu[index]);
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Text(
          'You can check your items here',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _InventoryBag extends StatelessWidget {
  const _InventoryBag({required this.items});

  final Items items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(items.imagePath.isEmpty ? 'Empty Slot' : items.name),
            content: items.imagePath.isEmpty
                ? const Text('This slot is currently empty.')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          items.imagePath,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(items.description),
                      const SizedBox(height: 8),
                      Text('Price: \$${items.price}'),
                      if (items.durability != null)
                        Text('Durability: ${items.durability!.label}'),
                    ],
                  ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: items.imagePath.isEmpty
              ? const Color(0xFF2A2A2A)
              : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: items.isLegendary
              ? Border.all(color: Colors.orange, width: 3)
              : null,
          image: items.imagePath.isNotEmpty
              ? DecorationImage(
                  image: AssetImage(items.imagePath),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: items.imagePath.isEmpty
            ? const Center(
                child: Text(
                  'Empty Slot',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
