import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/player.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';

class PlayerAddScreen extends StatefulWidget {
  const PlayerAddScreen({super.key});

  @override
  State<PlayerAddScreen> createState() => _PlayerAddScreenState();
}

class _PlayerAddScreenState extends State<PlayerAddScreen> {
  final PlayerBloc _playerBloc = getIt.get();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _playerBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Ajouter un joueur"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              const Spacer(),
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return OutlinedButton(
                    onPressed: () {
                      final player = _createPlayer();

                      _playerBloc.add(CreatePlayerEvent(playerEntity: player));

                      Navigator.pop(context);
                    },
                    child: const Text("Créer"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  PlayerEntity _createPlayer() {
    final player = PlayerEntity(
      name: nameController.text,
    );
    return player;
  }
}
