import 'package:nine_dart_score/data/entities/throw/throw.dart';
import 'package:nine_dart_score/domain/entities/throw/throw.dart';

class ThrowMapper {
  static Throw toData(ThrowEntity throwEntity) {
    return Throw(
      id: throwEntity.id,
      playerId: throwEntity.playerId,
      value: throwEntity.value,
    );
  }

  static ThrowEntity toEntity(Throw t) {
    return ThrowEntity(
      id: t.id,
      playerId: t.playerId,
      value: t.value,
    );
  }
}
