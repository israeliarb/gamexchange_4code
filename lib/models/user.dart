import 'package:flutter/material.dart';
import 'package:gamexchange_4code/provider/users.dart';
import 'package:geolocator/geolocator.dart';

class User with ChangeNotifier{
  final String id;
  final String nome;
  final String nickname;
  final String email;
  final String telefone;
  final String password;
  double latitude;
  double longitude;

  User({
    this.id,
    @required this.nome,
    @required this.nickname,
    @required this.email,
    @required this.telefone,
    @required this.password,
    this.latitude,
    this.longitude,
  });

}