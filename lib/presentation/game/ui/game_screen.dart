import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';

class GameScreen extends StatefulWidget {
  final GameBloc gameBloc;

  const GameScreen({
    super.key,
    required this.gameBloc,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _onNextTurn() {
    _controller.forward().then((_) {
      widget.gameBloc.add(NextTurnEvent());
      Future.delayed(
        const Duration(seconds: 1),
        () {
          _controller.reverse();
        },
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.gameBloc,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = _animation.value * 3.1415927;
              final isFront = angle < 1.5708;
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: isFront
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<GameBloc, GameState>(
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Game Id : ${state.game?.id}"),
                                    Text(
                                      "Au tour de ${state.game?.players?[state.currentPlayerIndex].name}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Score : ${state.game?.players?[state.currentPlayerIndex].score}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Derniers lancés"),
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
                              onPressed: _onNextTurn,
                            ),
                          ),
                        ],
                      )
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(3.1415927),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset("assets/test.json"),
                            const Center(
                              child: Text(
                                "Joueur suivant...",
                                style: TextStyle(fontSize: 24, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
