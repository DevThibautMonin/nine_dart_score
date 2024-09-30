import 'package:flutter/material.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class PlayerItem extends StatelessWidget {
  final PlayerEntity? playerEntity;
  final Function()? onDelete;

  const PlayerItem({
    super.key,
    this.onDelete,
    this.playerEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Gaps.gapW10,
              Icon(Icons.person, color: playerEntity?.color),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  playerEntity?.name ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
