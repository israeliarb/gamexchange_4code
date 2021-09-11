import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/models/xchange.dart';
//import 'package:flutter_app/data/musicas_exemplo.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:gamexchange_4code/models/user.dart';

class Xchanges with ChangeNotifier {
  static const _baseUrl =
      'https://code-gamexchange-default-rtdb.firebaseio.com/xchanges';
  List<Xchange> _items = []; /*{...Xchanges_EXEMPLO}*/
  String _token;
  String _userId;
  List<Xchange> get items => [..._items];

  Xchanges(this._token,this._userId,this._items);

  int get count {
    return _items.length;
  }

  Future<void> carregarXchanges() async {
    final response = await http.get(Uri.parse("$_baseUrl/$_userId.json?auth=$_token"));
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((xchangeId, xchangeData) {
        _items.add(Xchange(
          id: xchangeId,
          fkUserRecebe: xchangeData['fkUserRecebe'],
          fkUserEnvia: xchangeData['fkUserEnvia'],
          fkGame: xchangeData['fkGame'],
          categoria: xchangeData['categoria'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> adicionarXchange(Xchange novoXchange) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/$_userId.json"),
      body: json.encode({
        'fkUserRecebe': novoXchange.fkUserRecebe,
        'fkUserEnvia': novoXchange.fkUserEnvia,
        'fkGame': novoXchange.fkGame,
        'categoria': novoXchange.categoria,
      }),
    );

    _items.add(Xchange(
      id: json.decode(response.body)['name'],
      fkUserRecebe: novoXchange.fkUserRecebe,
      fkUserEnvia: novoXchange.fkUserEnvia,
      fkGame: novoXchange.fkGame,
      categoria: novoXchange.categoria,
    ));
    notifyListeners();
  }

  Future<void> atualizarXchange(Xchange xchange) async {
    if (xchange == null || xchange.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == xchange.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/$_userId/${xchange.id}.json?auth=$_token"),
        body: json.encode({
          'fkUserRecebe': xchange.fkUserRecebe,
          'fkUserEnvia': xchange.fkUserEnvia,
          'fkGame': xchange.fkGame,
          'categoria': xchange.categoria,
        }),
      );
      _items[index] = xchange;
      notifyListeners();
    }
  }

  Future<void> removerXchange(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final xchange = _items[index];
      _items.remove(xchange);
      notifyListeners();

      final response =
          await http.delete(Uri.parse("$_baseUrl/$_userId/${xchange.id}.json?auth=$_token"));

      if (response.statusCode >= 400) {
        _items.insert(index, xchange);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do xchange.');
      }
    }
  }
}
