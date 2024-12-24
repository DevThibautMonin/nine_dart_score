import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nine_dart_score/core/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  asExtension: true,
)
void configureDependencies() => getIt.init();
