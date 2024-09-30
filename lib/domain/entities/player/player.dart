import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'player.mapper.dart';

@MappableClass()
class PlayerEntity with PlayerEntityMappable {
  final int? id;
  final String? name;
  final int? score;
  final Color? color;

  PlayerEntity({
    this.id,
    this.name,
    this.score,
    this.color,
  });
}
