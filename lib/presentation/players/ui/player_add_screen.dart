import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/domain/entities/player/player.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';
import 'package:nine_dart_score/widgets/custom_button.dart';
import 'package:nine_dart_score/widgets/custom_textfield.dart';

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
  ];
  Color _selectedColor = Colors.red;

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
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextfield(
                  controller: nameController,
                  labelText: "Nom",
                  onChanged: (name) {
                    _playerBloc.add(PlayerNameChanged(playerName: name));
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _playerColors.length,
                  itemBuilder: (context, index) {
                    final color = _playerColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                        _playerBloc.add(PlayerColorChanged(playerColor: color));
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: _selectedColor == color ? 30 : 20,
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomButton(
                      text: "Créer",
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
    );
  }

  PlayerEntity _createPlayer() {
    final player = PlayerEntity(
      name: nameController.text,
      color: _selectedColor,
    );
    return player;
  }
}
