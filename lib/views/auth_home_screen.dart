import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import 'games_overview_screen.dart';
import 'login_overview_screen.dart';
class AuthOrHomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? GameOverviewScreen() : LoginOverviewScreen() ;

   return Container(

   );
  }
}