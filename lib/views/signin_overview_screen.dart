
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/widgets/registro_card.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import 'package:gamexchange_4code/provider/users.dart';
class SigninOverviewScreen extends StatelessWidget {

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
           RegistroCard(),
        ],
      ),
    );
  }
}