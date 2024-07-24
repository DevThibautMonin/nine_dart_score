import 'package:get_it/get_it.dart';
import 'package:nine_dart_score/data/database.dart';
import 'package:nine_dart_score/data/datasources/local/game_local_datasource.dart';
import 'package:nine_dart_score/data/datasources/local/player_local_datasource.dart';
import 'package:nine_dart_score/data/repositories/game_repository.dart';
import 'package:nine_dart_score/data/repositories/player_repository.dart';
import 'package:nine_dart_score/domain/usecases/game/create_game_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/create_player_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/delete_player_usecase.dart';
import 'package:nine_dart_score/domain/usecases/player/get_players_usecase.dart';
import 'package:nine_dart_score/presentation/game/bloc/game_bloc.dart';
import 'package:nine_dart_score/presentation/players/bloc/player_bloc.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton(() => Database());

  // Player
  getIt.registerLazySingleton(() => CreatePlayerUsecase());
  getIt.registerLazySingleton(() => GetPlayersUsecase());
  getIt.registerLazySingleton(() => DeletePlayerUsecase());
  getIt.registerLazySingleton(() => PlayerRepository());
  getIt.registerLazySingleton(() => PlayerLocalDatasource());
  getIt.registerLazySingleton(() => PlayerBloc());

  // Game
  getIt.registerFactory(() => GameBloc());
  getIt.registerFactory(() => GameLocalDatasource());
  getIt.registerFactory(() => GameRepository());
  getIt.registerFactory(() => CreateGameUsecase());
}
