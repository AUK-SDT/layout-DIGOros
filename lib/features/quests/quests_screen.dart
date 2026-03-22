import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import '../../state/app_state.dart';
import '../../core/widgets/gold_display.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onQuestToggled(int index, bool isCompleted) {
    final appState = context.read<AppState>();
    appState.toggleQuest(index);
    
    // Play confetti only if it was just completed
    if (appState.quests[index].isCompleted) {
      _confettiController.play();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Quest Completed! +50 Gold!'),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green[800],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quests = context.watch<AppState>().quests;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Quests'),
        actions: [
          const GoldDisplay(),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AppState>().resetQuests(),
            tooltip: 'Reset Progress',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          quests.isEmpty 
            ? const Center(child: Text('No quests available.'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: quests.length,
                itemBuilder: (context, index) {
                  final quest = quests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: CheckboxListTile(
                      title: Text(
                        quest.title,
                        style: TextStyle(
                          decoration: quest.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: quest.isCompleted
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      value: quest.isCompleted,
                      onChanged: (bool? value) => _onQuestToggled(index, value ?? false),
                      activeColor: Theme.of(context).primaryColor,
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
              Colors.purple,
            ],
            createParticlePath: _drawStar,
          ),
        ],
      ),
    );
  }

  Path _drawStar(Size size) {
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
      path.lineTo(
        halfWidth + externalRadius * math.cos(step),
        halfWidth + externalRadius * math.sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * math.cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * math.sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }
}
