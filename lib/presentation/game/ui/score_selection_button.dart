import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/game/ui/score_selection_dialog.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';

class ScoreSelectionButton extends StatelessWidget {
  final int? score;
  final String label;
  final Function(int?) onScoreSelected;

  const ScoreSelectionButton({
    super.key,
    required this.label,
    this.score,
    required this.onScoreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var score = await showDialog(
          context: context,
          builder: (context) {
            return const ScoreSelectionDialog();
          },
        );
        onScoreSelected(score);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CustomColors.primaryBlue),
        ),
        alignment: Alignment.center,
        child: Text(
          score == null ? label : score?.toString() ?? "",
          style: const TextStyle(fontSize: 16, color: CustomColors.primaryBlue),
        ),
      ),
    );
  }
}
