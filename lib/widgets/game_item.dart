import 'package:flutter/material.dart';
import '../models/game.dart';

class GameItem extends StatelessWidget{

  final Game game;

  GameItem(this.game);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(
          game.imageUrl,
          fit: BoxFit.cover,

        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Image.asset('assets/icons/xchange.png'),
            iconSize: 10,
            onPressed: () {},
          ),
          title: Text(
            game.xchange,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.article),
            onPressed: (){},
          ),
        ),
    );
  }

}