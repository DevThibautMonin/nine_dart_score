import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/players/ui/player_list.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {},
      ),
      body: const Column(
        children: [
          Expanded(
            child: PlayerList(),
          ),
        ],
      ),
    );
  }
}
