import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:gamexchange_4code/data/store.dart';
import 'package:gamexchange_4code/exceptions/auth_exception.dart';
import 'package:gamexchange_4code/models/user.dart';
import 'package:gamexchange_4code/provider/users.dart';

import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String _userId;
  String _token;
  DateTime _expiryDate;
  Timer _logoutTimer;
  User _currentUser;

  bool get isAuth {
    return token != null;
  }

  User get currentUser {
    return isAuth? _currentUser: null;
  }

  String get userId {
    return isAuth ? _userId : null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }



  Future<void> _authenticate(String email, String password, String urlSegment, BuildContext context) async {
    Users users = Provider.of<Users>(context, listen: false);


    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyATZVD3Ar0PjREpePDxiKZ01RsmmvZCZ_E';

    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    final responseBody = json.decode(response.body);
    if (responseBody["error"] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      await users.carregarUser();


      _token = responseBody["idToken"];
      _userId = responseBody["localId"];
      _currentUser = await users.findUserByEmail(email);
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );

      Store.saveMap('userData', {
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> signup(String email, String password, BuildContext context) async {
    return _authenticate(email, password, "signUp", context);
  }

  Future<void> login(String email, String password, BuildContext context) async {
    return _authenticate(email, password, "signInWithPassword", context);
  }

  Future<void> tryAutoLogin() async {
    if(isAuth) {
      return Future.value();
    }

    final userData = await Store.getMap('userData');
    if(userData == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData["expiryDate"]);

    if(expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _userId = userData["userId"];
    _token = userData["token"];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
    return Future.value();
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    Store.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }
    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}


