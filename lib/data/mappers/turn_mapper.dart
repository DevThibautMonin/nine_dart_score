import 'package:nine_dart_score/data/entities/turn/turn.dart';
import 'package:nine_dart_score/data/mappers/throw_mapper.dart';
import 'package:nine_dart_score/domain/entities/turn/turn.dart';

class TurnMapper {
  static Turn toData(TurnEntity turnEntity) {
    return Turn(
      id: turnEntity.id,
      throws: turnEntity.throws?.map((throwEntity) => ThrowMapper.toData(throwEntity)).toList(),
      playerId: turnEntity.playerId,
    );
  }

  static TurnEntity toEntity(Turn turn) {
    return TurnEntity(
      id: turn.id,
      throws: turn.throws?.map((t) => ThrowMapper.toEntity(t)).toList(),
      playerId: turn.playerId,
    );
  }
}
