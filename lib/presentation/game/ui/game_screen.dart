import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/themes/custom_colors.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/custom_textfield.dart';
import 'package:nine_dart_score/widgets/gaps.dart';
import 'package:nine_dart_score/widgets/score_bottom_sheet.dart';

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
  final TextEditingController _firstScoreController = TextEditingController();
  final TextEditingController _secondScoreController = TextEditingController();
  final TextEditingController _thirdScoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.gameBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Text("${widget.gameBloc.state.game?.name}");
            },
          ),
          actions: [
            IconButton.outlined(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ScoreBottomSheet(
                      gameBloc: widget.gameBloc,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.scoreboard,
                color: CustomColors.primaryBlue,
              ),
            ),
            Gaps.gapW10,
            IconButton.outlined(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      icon: Icon(Icons.exit_to_app),
                      title: Text("Attention"),
                      content: Column(
                        children: [
                          Text("Êtes-vous sûr de vouloir quitter la partie en cours ?"),
                        ],
                      ),
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(text: "Non"),
                            ),
                            Gaps.gapW15,
                            Expanded(
                              child: CustomButton(text: "Oui"),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
            ),
            Gaps.gapW10,
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                            "Tour n° ${state.turnNumber} : ${state.game?.players?[state.currentPlayerIndex].name}",
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
                          const Text("Liste des derniers lancés"),
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: BlocBuilder<GameBloc, GameState>(
                              builder: (context, state) {
                                var currentPlayerId = state.game?.players?[state.currentPlayerIndex].id;
                                if (state.game?.turns?.isEmpty ?? true) {
                                  return const Text("Vous n'avez pas encore joué !");
                                }
                                return ListView.builder(
                                  itemCount: state.game?.turns?.length,
                                  itemBuilder: (context, index) {
                                    final turn = state.game?.turns?[index];
                                    if (turn?.playerId == currentPlayerId) {
                                      return Row(
                                        children: [
                                          Text("${turn?.throws?.first.value ?? 0}"),
                                          Gaps.gapW10,
                                          Text("${turn?.throws?.elementAt(1).value ?? 0}"),
                                          Gaps.gapW10,
                                          Text("${turn?.throws?.last.value ?? 0}"),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          controller: _firstScoreController,
                          labelText: "Score 1",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gaps.gapW10,
                      Expanded(
                        child: CustomTextfield(
                          controller: _secondScoreController,
                          labelText: "Score 2",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gaps.gapW10,
                      Expanded(
                        child: CustomTextfield(
                          controller: _thirdScoreController,
                          labelText: "Score 3",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    text: "Joueur suivant",
                    onPressed: () {
                      var firstThrow = int.parse(_firstScoreController.text.isNotEmpty ? _firstScoreController.text : 0.toString());
                      var secondThrow = int.parse(_secondScoreController.text.isNotEmpty ? _secondScoreController.text : 0.toString());
                      var thirdThrow = int.parse(_thirdScoreController.text.isNotEmpty ? _thirdScoreController.text : 0.toString());

                      widget.gameBloc.add(NextPlayerEvent(firstThrow: firstThrow, secondThrow: secondThrow, thirdThrow: thirdThrow));

                      _firstScoreController.clear();
                      _secondScoreController.clear();
                      _thirdScoreController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
