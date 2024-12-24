import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_dart_score/core/di/injectable.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';
import 'package:nine_dart_score/presentation/players/ui/player_item.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  final PlayerBloc _playerBloc = getIt.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _playerBloc..add(GetPlayersEvent()),
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          switch (state.playerStatus) {
            case PlayerStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PlayerStatus.loaded:
              final players = state.players;
              if (players == null || players.isEmpty) {
                return const Center(child: Text("Pour commencer, ajoutez un joueur."));
              } else {
                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return PlayerItem(
                      onDelete: () {
                        _playerBloc.add(DeletePlayerEvent(playerId: players[index].id ?? 0));
                      },
                      playerEntity: players[index],
                    );
                  },
                );
              }
            default:
              return Container();
          }
        },
      ),
    );
  }
}
