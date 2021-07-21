
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/models/user.dart';
import 'package:gamexchange_4code/widgets/auth_card.dart';

class LoginOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
       Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/icons/fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
       ),
          AuthCard(),
      ],
        ),
      );

    }
}