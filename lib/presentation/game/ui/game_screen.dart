import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';

class GameScreen extends StatelessWidget {
  final GameBloc gameBloc;

  const GameScreen({
    super.key,
    required this.gameBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: gameBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(state.targetScore ?? "");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
