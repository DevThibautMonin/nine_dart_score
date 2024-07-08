import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/players/player_item.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return PlayerItem(
          onDelete: () {},
        );
      },
    );
  }
}
