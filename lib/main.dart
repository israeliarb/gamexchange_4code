import 'package:gamexchange_4code/provider/games.dart';
import 'package:gamexchange_4code/provider/users.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/views/auth_home_screen.dart';
import 'package:gamexchange_4code/widgets/registro_card.dart';

import'package:provider/provider.dart';
import './views/games_overview_screen.dart';
import './views/login_overview_screen.dart';
import './views/signin_overview_screen.dart';
import './views/game_form.dart';
import './views/mygames_list.dart';

import './routes/AppRotas.dart';
import './provider/users.dart';
import './provider/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),

        ChangeNotifierProvider<Users>(
          create: (_) => Users(),
        ),

        ChangeNotifierProxyProvider<Auth, Games>(
          create:(_) => new Games(null, null, []),
          update: (ctx,auth,previousGames) => new Games(auth.token,auth.userId,previousGames.items,),
        ),
        /*
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => new Orders(),
          update: (ctx, auth, previousOrders) => new Orders(
            auth.token,
            auth.userId,
            previousOrders.items,
          ),
        ),*/
      ],
      child: MaterialApp(
        title: 'gameXchange',
        theme: ThemeData.dark(
          //primarySwatch: Colors.purple,
          //accentColor: Colors.deepOrange,
          //fontFamily: 'Lato',
        ),
        routes: {
          AppRotas.AUTH: (ctx) => AuthOrHomeScreen(),
          AppRotas.GAME: (ctx) => GameOverviewScreen(),
          AppRotas.REGISTRO: (ctx) => SigninOverviewScreen(),
          AppRotas.GAME_FORM: (ctx) => GameForm(),
          AppRotas.MY_GAMES: (ctx) => MyGameList(),
        },
      ),
    );
  }
}
