import 'package:flutter/material.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import '../models/game.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import 'package:gamexchange_4code/models/user.dart';
import '../widgets/game_item.dart';
import 'package:gamexchange_4code/provider/users.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/games.dart';
import '../provider/games.dart';


class UserItem extends StatelessWidget{
  final User user;

  UserItem(this.user);


  @override
  Widget build(BuildContext context) {
    print(user);
    final Games games = Provider.of(context);
    final game = games.items;

    return Column(
      children: [
        Text(
          user.nome,
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey[200],
              fontFamily: 'Anton'),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 250,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            //padding: const EdgeInsets.all(10),
            itemCount: games.count,
            itemBuilder: (ctx, i) =>
                GameItem(game[i]),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                //maxCrossAxisExtent: 200,
                childAspectRatio: 4 / 3,
                mainAxisSpacing: 10),
          ),
        ),
      ],
    );
  }

}