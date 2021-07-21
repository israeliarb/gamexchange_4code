import 'package:flutter/foundation.dart';

class Game{
  final String fkUser;
  final String id;
  final String nome;
  final String xchange;
  final String plataforma;
  final String estado;
  final String imageUrl;
  bool isActive;

  Game({
    this.fkUser,
    @required this.id,
    @required this.nome,
    @required this.xchange,
    @required this.plataforma,
    @required this.estado,
    @required this.imageUrl,
    this.isActive = false
  });
}