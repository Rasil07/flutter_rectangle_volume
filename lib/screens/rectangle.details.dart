import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rectangle_volume/model/rectangle.model.dart';

class RectangleDetail extends StatelessWidget {
  const RectangleDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final m = context.watch<RectangleModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Screen 2: Calculate Volume')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Length:  ${m.length}'),
            Text('Breadth: ${m.breadth}'),
            Text('Depth:   ${m.depth}'),
            const SizedBox(height: 16),
            Text(
              m.volume == null ? 'Volume: —' : 'Volume: ${m.volume}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Row(
              children: [
                FilledButton(
                  onPressed: () {
                    // Button 1: calculate and display volume on Screen 2
                    context.read<RectangleModel>().computeVolume();
                  },
                  child: const Text('Calculate Volume'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  // Button 2: back to Screen 1; Screen 1 will also show volume
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Screen 1'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
