import 'package:flutter/material.dart';
import 'package:nine_dart_score/features/players/domain/entities/player/player.dart';
import 'package:nine_dart_score/shared/presentation/themes/custom_colors.dart';

class PlayerSettingsChip extends StatelessWidget {
  final PlayerEntity? player;
  final bool isSelected;
  final Function(bool) onSelected;

  const PlayerSettingsChip({
    super.key,
    this.player,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ChoiceChip(
        label: Text(
          player?.name ?? "",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: CustomColors.primaryBlue,
        backgroundColor: Colors.white,
        avatar: isSelected
            ? null
            : CircleAvatar(
                backgroundColor: CustomColors.primaryBlue,
                child: Text(
                  player?.name?[0] ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
