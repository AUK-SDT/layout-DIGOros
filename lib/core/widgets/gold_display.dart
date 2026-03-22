import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class GoldDisplay extends StatelessWidget {
  const GoldDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = context.watch<AppState>().gold;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.monetization_on, color: Colors.orange, size: 24),
        const SizedBox(width: 4),
        Text(
          '$gold',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
