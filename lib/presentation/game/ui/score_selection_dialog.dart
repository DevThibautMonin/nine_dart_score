import 'package:flutter/material.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class ScoreSelectionDialog extends StatelessWidget {
  const ScoreSelectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Sélectionnez votre score',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Gaps.gapH15,
            Expanded(
              child: GridView.builder(
                itemCount: 60,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  final score = index + 1;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: Text(
                      '$score',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, score);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
