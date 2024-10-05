import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nine_dart_score/core/di/get_it_setup.dart';
import 'package:nine_dart_score/presentation/history/bloc/history_bloc.dart';
import 'package:nine_dart_score/presentation/history/ui/history_details.dart';
import 'package:nine_dart_score/presentation/history/ui/history_item.dart';
import 'package:nine_dart_score/widgets/animations/route_animation.dart';
import 'package:nine_dart_score/widgets/gaps.dart';

class HistoryList extends StatelessWidget {
  final HistoryBloc _historyBloc = getIt.get();

  HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _historyBloc..add(const GetHistoryGameListEvent()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          switch (state.historyStatusEnum) {
            case HistoryStatusEnum.loading:
              return const Center(child: CircularProgressIndicator());
            case HistoryStatusEnum.loaded:
              if (state.games.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.games.length,
                    itemBuilder: (context, index) {
                      return HistoryItem(
                        gameName: state.games[index].name,
                        playerCount: state.games[index].players?.length,
                        onDelete: () {
                          _historyBloc.add(DeleteGameEvent(id: state.games[index].id ?? 0));
                        },
                        onTap: () {
                          Navigator.of(context).push(createRouteWithTransition(
                            child: HistoryDetails(gameEntity: state.games[index]),
                            direction: TransitionDirection.fromDiagBottomRight,
                          ));
                        },
                      );
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network("https://lottie.host/3577780a-3bcd-4ca4-9bab-d46c7778d099/kfJzoQN9Nn.json"),
                        Gaps.gapH25,
                        const Text(
                          "Aucune partie trouvée !",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
