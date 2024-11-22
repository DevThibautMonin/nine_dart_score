import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/commons/constants.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/custom_textfield.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class PlayerAddScreen extends StatefulWidget {
  const PlayerAddScreen({super.key});

  @override
  State<PlayerAddScreen> createState() => _PlayerAddScreenState();
}

class _PlayerAddScreenState extends State<PlayerAddScreen> {
  final PlayerBloc _playerBloc = getIt.get();
  final TextEditingController nameController = TextEditingController();
  final List<Color> _playerColors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
  ];

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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                  controller: nameController,
                  isMandatory: true,
                  labelText: "Pseudo",
                  onChanged: (name) {
                    _playerBloc.add(PlayerNameChanged(playerName: name));
                  },
                ),
                Gaps.gapH10,
                const Text(
                  "Couleur*",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.gapH10,
                SizedBox(
                  height: 100,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      _playerColors.length,
                      (index) {
                        final color = _playerColors[index];
                        return GestureDetector(
                          onTap: () {
                            _playerBloc.add(PlayerColorChanged(playerColor: color));
                          },
                          child: BlocBuilder<PlayerBloc, PlayerState>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: color,
                                    radius: 20,
                                  ),
                                  if (state.playerColor == color)
                                    const Positioned(
                                      top: 5,
                                      left: 5,
                                      child: Icon(
                                        Icons.check,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        text: Constants.create,
                        isEnabled: state.isFormValid(),
                        onPressed: () {
                          final player = _createPlayer();

                          _playerBloc.add(CreatePlayerEvent(playerEntity: player));

                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PlayerEntity _createPlayer() {
    final player = PlayerEntity(
      name: nameController.text,
      color: _playerBloc.state.playerColor,
    );
    return player;
  }
}
