import 'package:flutter/material.dart';

class User with ChangeNotifier{
  final String id;
  final String nome;
  final String nickname;
  final String email;
  final String telefone;
  final String password;


  User({
    this.id,
    @required this.nome,
    @required this.nickname,
    @required this.email,
    @required this.telefone,
    @required this.password,

  });
}