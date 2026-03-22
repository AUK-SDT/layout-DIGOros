import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../models/item.dart';
import '../../core/widgets/gold_display.dart';
import '../../core/widgets/rpg_card.dart';
import '../../core/widgets/app_button.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopItems = context.watch<AppState>().shopItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Merchant\'s Ledger'),
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
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: shopItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _ShopListItem(item: shopItems[index]);
              },
            ),
    );
  }
}

class _ShopListItem extends StatelessWidget {
  final Item item;

  const _ShopListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();

    return RPGCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderColor: item.isLegendary ? Colors.orange : null,
      child: Row(
        children: [
          // Image (left, small)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imagePath,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 64,
                    color: Colors.white10,
                    child: const Icon(Icons.broken_image, color: Colors.white24, size: 32),
                  ),
                ),
              ),
              if (item.isLegendary)
                const Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(Icons.star, color: Colors.orange, size: 20),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Name and Description (center)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Price and "Buy" Button (right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${item.price.toInt()}',
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppButton(
                label: 'Buy',
                onPressed: () {
                  // Capacity check
                  if (!appState.inventory.any((i) => i.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Inventory Full! Please sell or delete something first.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  // Gold check
                  if (appState.gold < item.price) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Not enough gold to buy this item!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Buy
                  appState.buyItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully purchased ${item.name}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
