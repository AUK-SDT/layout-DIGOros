import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../models/item.dart';
import '../../core/widgets/gold_display.dart';
import '../../core/widgets/rpg_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopItems = context.watch<AppState>().shopItems;
    final isHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventurer\'s Shop'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GoldDisplay(),
          ),
        ],
      ),
      body: shopItems.isEmpty
          ? const Center(
              child: Text(
                'The shop is currently empty.\nComplete more quests to unlock new items!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: shopItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isHorizontal ? 4 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return _ShopGridItem(index: index);
                },
              ),
            ),
    );
  }
}

class _ShopGridItem extends StatelessWidget {
  final int index;

  const _ShopGridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final item = context.watch<AppState>().shopItems[index];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (!appState.inventory.any((i) => i.isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Inventory Full! Please sell or delete something first.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        _showPurchaseConfirmation(context, appState, item, index);
      },
      child: RPGCard(
        padding: EdgeInsets.zero,
        borderColor: item.isLegendary ? Colors.orange : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                    ),
                    if (item.isLegendary)
                      const Positioned(
                        top: 8,
                        left: 8,
                        child: Icon(Icons.star, color: Colors.orange, size: 24),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${item.price.toInt()}',
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseConfirmation(
    BuildContext context,
    AppState appState,
    Item item,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Purchase ${item.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(item.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Price: '),
                const Icon(Icons.monetization_on, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${item.price.toInt()}',
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (appState.gold >= item.price) {
                appState.buyItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully purchased ${item.name}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Not enough gold to buy this item!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}
