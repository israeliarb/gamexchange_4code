import 'package:flutter/foundation.dart';

class GameList{
  String fkUser;
  String userNick;
  String id;
  String nome;
  String xchange;
  String plataforma;
  String estado;
  String imageUrl;
  bool isActive;

  GameList({
    this.fkUser,
    this.userNick,
    this.id,
    this.nome,
    this.xchange,
    this.plataforma,
    this.estado,
    this.imageUrl,
    this.isActive = false
  });
}