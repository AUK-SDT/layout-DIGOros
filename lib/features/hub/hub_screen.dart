import 'package:flutter/material.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/gold_display.dart';
import '../inventory/inventory_screen.dart';
import '../quests/quests_screen.dart';
import '../shop/shop_screen.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Hub'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GoldDisplay(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fort,
                size: 100,
                color: Colors.white24,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome back, Adventurer!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AppButton(
                label: 'Open Inventory',
                icon: Icons.inventory_2,
                isFullWidth: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InventoryScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'View Quests',
                icon: Icons.assignment,
                isFullWidth: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuestsScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Visit Merchant',
                icon: Icons.store,
                isFullWidth: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShopScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
