import 'package:flutter/foundation.dart';

class Xchange{
  final String fkUserRecebe;
  final String fkUserEnvia;
  final String fkGame;
  final String id;
  final String categoria;
  bool isActive;

  Xchange({
    this.fkUserRecebe,
    this.fkUserEnvia,
    this.fkGame,
    @required this.id,
    @required this.categoria,
    this.isActive = false
  });
}