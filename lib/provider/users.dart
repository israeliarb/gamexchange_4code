import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/models/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'auth.dart';
import 'games.dart';

class Users with ChangeNotifier {
  static const _baseUrl = 'https://code-gamexchange-default-rtdb.firebaseio.com/users';
  List<User> _items = [];

  List<User> get items => [..._items];

  int get Usercount {
    return _items.length;
  }

  Future<void> carregarUser() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((userId, userData) {
        print(userData['local']);
        _items.add(User(
          id: userId,
          nome: userData['nome'],
          nickname: userData['nickname'],
          email: userData['email'],
          telefone: userData['telefone'],
          password: userData['password'],
          latitude: userData['latitude'], //tipo position não pode ser atribuído a string
          longitude: userData['longitude'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> adicionarUser(User novoUser) async {
    final response = await http.post(
      Uri.parse("$_baseUrl.json"),
      body: json.encode({
        'nome': novoUser.nome,
        'nickname': novoUser.nickname,
        'email': novoUser.email,
        'telefone': novoUser.telefone,
        'password': novoUser.password,
        'latitude':novoUser.latitude,
        'longitude': novoUser.longitude,
      }),
    );

    _items.add(User(
      id: json.decode(response.body)['name'],
      nome: novoUser.nome,
      nickname: novoUser.nickname,
      email: novoUser.email,
      telefone: novoUser.telefone,
      password: novoUser.password,
      latitude: novoUser.latitude,
      longitude: novoUser.longitude,
    ));
    notifyListeners();
  }

  Future<void> atualizarUser(User user) async {
    if (user == null || user.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == user.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${user.id}.json"),
        body: json.encode({
          'nome': user.nome,
          'nickname': user.nickname,
          'email': user.email,
          'telefone': user.telefone,
          'password': user.password,
          'latitude': user.latitude,
          'longitude': user.longitude,
        }),
      );
      _items[index] = user;
      notifyListeners();
    }
  }

  Future<void> removerUser(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final user = _items[index];
      _items.remove(user);
      notifyListeners();

      final response = await http.delete(Uri.parse("$_baseUrl/${user.id}.json"));

      if (response.statusCode >= 400) {
        _items.insert(index, user);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do usuário.');
      }
    }
  }

  Future<User> findUserByEmail(String email) async {
    await carregarUser();
    final index = _items.indexWhere((prod) => prod.email == email);
    if(index >= 0){
      final user = _items[index];
      // notifyListeners();
      return user;
    }
  }

  Users ordenaDistancia(Users lista, User atual) {
    Users listaOrdenada = lista;

    Users aux =  lista;
    for(var j = 0; j<(lista.Usercount);j++){
      for(var i = 1; i<(lista.Usercount);i++){
        User userA = lista._items[i-1];
        User userB = lista._items[i];
        if(userA != atual){
          var p = 0.017453292519943295;
          var c = cos;
          var a = 0.5 - c((userA.latitude - atual.latitude) * p)/2 +
              c(atual.latitude * p) * c(userA.latitude * p) *
                  (1 - c((userA.longitude - atual.longitude) * p))/2;
          var b = 0.5 - c((userB.latitude - atual.latitude) * p)/2 +
              c(atual.latitude * p) * c(userB.latitude * p) *
                  (1 - c((userB.longitude - atual.longitude) * p))/2;
          var distanciaA = 12742 * asin(sqrt(a));
          var distanciaB = 12742 * asin(sqrt(b));


          if(distanciaB <= distanciaA) {
            aux._items[0] = listaOrdenada._items[i - 1];
            listaOrdenada._items[i - 1] = lista._items[i];
            listaOrdenada._items[i] = aux._items[0];
          }
        }
      }
    }
    listaOrdenada._items[0] = atual;
    return listaOrdenada;
  }
  Users getOrdenado(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context, listen: false);
    Users _users = Provider.of<Users>(context, listen: false);
    User _user = _auth.currentUser;
    print(_user);

    //List<Users> _ordenado = [null];

    Users _ordenado = ordenaDistancia(_users, _user);
    //Provider.of<Games>(context, listen: false).carregarUserGames(_ordenado._items[0].id);
    //Games games = Provider.of(context);

    return _ordenado;
  }
}