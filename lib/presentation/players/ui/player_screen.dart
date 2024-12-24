import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/injectable.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';
import 'package:nine_dart_score/presentation/players/ui/player_add_screen.dart';
import 'package:nine_dart_score/presentation/players/ui/player_list.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerBloc _playerBloc = getIt.get();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _playerBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add),
          onPressed: () async {
            await Navigator.of(context).push(
              createRouteWithTransition(
                child: const PlayerAddScreen(),
                direction: TransitionDirection.fromDiagBottomRight,
              ),
            );
          },
        ),
        body: const Column(
          children: [
            Expanded(
              child: PlayerList(),
            ),
          ],
        ),
      ),
    );
  }
}
