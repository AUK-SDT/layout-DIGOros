import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../models/item.dart';
import '../../core/widgets/gold_display.dart';
import '../../core/widgets/rpg_card.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inventory = context.watch<AppState>().inventory;
    final isHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Inventory'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GoldDisplay(),
          ),
        ],
      ),
      body: inventory.isEmpty 
        ? const Center(child: Text('Your inventory is empty.'))
        : Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: inventory.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isHorizontal ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return _InventoryGridItem(index: index);
              },
            ),
          ),
    );
  }
}

class _InventoryGridItem extends StatefulWidget {
  final int index;

  const _InventoryGridItem({required this.index});

  @override
  State<_InventoryGridItem> createState() => _InventoryGridItemState();
}

class _InventoryGridItemState extends State<_InventoryGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final item = appState.inventory[widget.index];

    if (item.isEmpty) {
      return RPGCard(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    return RPGCard(
      padding: EdgeInsets.zero,
      borderColor: item.isLegendary 
        ? Colors.orange 
        : (_isHovered ? Colors.white24 : null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showItemDetails(context, item),
                  onHover: (value) => setState(() => _isHovered = value),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorite ? Colors.red : Colors.white70,
                ),
                onPressed: () => appState.toggleFavorite(widget.index),
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
                onPressed: () => appState.deleteItem(widget.index),
                iconSize: 20,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item.name),
        content: item.isEmpty
            ? const Text('This slot is currently empty.')
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.imagePath.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.imagePath,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(item.description),
                    const SizedBox(height: 8),
                    Text('Price: \$${item.price.toStringAsFixed(0)}'),
                    if (item.durability != null)
                      Text('Durability: ${item.durability!.label}'),
                  ],
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
