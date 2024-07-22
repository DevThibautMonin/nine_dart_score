import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';

class GameScreen extends StatelessWidget {
  final GameBloc gameBloc;

  const GameScreen({
    super.key,
    required this.gameBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: gameBloc..add(StartGameEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Au tour de ${state.players?[state.currentPlayerIndex].name}",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Text(state.targetScore ?? ""),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  text: "Tour suivant",
                  onPressed: () {
                    gameBloc.add(NextTurnEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
