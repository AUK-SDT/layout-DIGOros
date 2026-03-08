import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import 'item.dart';

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

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int _selectedIndex = 0;
  int _gold = 100;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  final List<Item> _inventory = [
    Item(
      name: 'Flame Sword',
      description:
          'A balanced steel blade. It`s blade set ablaze with holy flames.',
      price: 120,
      imagePath: 'Assets/images/Sword.png',
      durability: Durability.max,
      isLegendary: true,
    ),
    Item(
      name: 'Paladin Plate Armor',
      description:
          'Heavy armor that greatly increases defense with divine protection.',
      price: 350,
      imagePath: 'Assets/images/Armor.png',
      durability: Durability.medium,
      isLegendary: true,
    ),
    Item(
      name: 'Health Potion',
      description: 'Restores 50 HP instantly.',
      price: 60,
      imagePath: 'Assets/images/Potion.png',
    ),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
    Item(name: 'Empty Slot', description: '', price: 0, imagePath: ''),
  ];

  final List<Quest> _quests = [
    Quest(title: 'Slay 10 Goblins'),
    Quest(title: 'Find the Lost Ring'),
    Quest(title: 'Craft a Flame Sword'),
    Quest(title: 'Visit the Tavern'),
    Quest(title: 'Level up to 5'),
  ];

  void _toggleQuest(int index) {
    setState(() {
      _quests[index].isCompleted = !_quests[index].isCompleted;
      if (_quests[index].isCompleted) {
        _gold += 50;
        _confettiController.play();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Quest Completed! +50 Gold!'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green[800],
          ),
        );
      } else {
        _gold -= 50;
      }
    });
  }

  void _resetQuests() {
    setState(() {
      for (var quest in _quests) {
        quest.isCompleted = false;
      }
      _gold = 100;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _inventory.removeAt(index);
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _inventory[index].isFavorite = !_inventory[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Your Inventory' : 'Active Quests'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.orange),
                const SizedBox(width: 4),
                Text('$_gold', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (_selectedIndex == 1)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetQuests,
              tooltip: 'Reset Progress',
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _selectedIndex == 0
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: _inventory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isHorizontal ? 4 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return _InventoryBag(
                        items: _inventory[index],
                        onDelete: () => _deleteItem(index),
                        onToggleFavorite: () => _toggleFavorite(index),
                      );
                    },
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _quests.length,
                  itemBuilder: (context, index) {
                    final quest = _quests[index];
                    return Card(
                      color: const Color(0xFF1E1E1E),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: CheckboxListTile(
                        title: Text(
                          quest.title,
                          style: TextStyle(
                            decoration: quest.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: quest.isCompleted ? Colors.grey : Colors.white,
                          ),
                        ),
                        value: quest.isCompleted,
                        onChanged: (bool? value) {
                          _toggleQuest(index);
                        },
                        activeColor: const Color(0xFFB98068),
                        checkColor: Colors.black,
                      ),
                    );
                  },
                ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: _drawStar,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFFB98068),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Quests',
          ),
        ],
      ),
    );
  }

  /// A custom path to draw stars for the confetti
  Path _drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (math.pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * math.cos(step),
          halfWidth + externalRadius * math.sin(step));
      path.lineTo(halfWidth + internalRadius * math.cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * math.sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}

class _InventoryBag extends StatefulWidget {
  const _InventoryBag({
    required this.items,
    required this.onDelete,
    required this.onToggleFavorite,
  });

  final Item items;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;

  @override
  State<_InventoryBag> createState() => _InventoryBagState();
}

class _InventoryBagState extends State<_InventoryBag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final items = widget.items;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _onTap(context),
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: items.imagePath.isEmpty
              ? const Color(0xFF2A2A2A)
              : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: items.isLegendary
              ? Border.all(color: Colors.orange, width: 3)
              : _isHovered 
                  ? Border.all(color: Colors.white24, width: 2)
                  : null,
          image: items.imagePath.isNotEmpty
              ? DecorationImage(
                  image: AssetImage(items.imagePath),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: [
            if (items.imagePath.isEmpty)
              const Center(
                child: Text(
                  'Empty Slot',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (items.imagePath.isNotEmpty) ...[
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    items.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: items.isFavorite ? Colors.red : Colors.white70,
                  ),
                  onPressed: widget.onToggleFavorite,
                  iconSize: 20,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white70),
                  onPressed: widget.onDelete,
                  iconSize: 20,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final items = widget.items;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(items.name),
        content: items.isEmpty
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
                  if (items.isFavorite)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('❤️ Favorite Item', style: TextStyle(color: Colors.redAccent)),
                    ),
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
  }
}
