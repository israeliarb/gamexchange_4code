import 'package:flutter/material.dart';
import '../models/game.dart';

class MyGameItem extends StatelessWidget{

  final Game mygame;

  MyGameItem(this.mygame);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(
          mygame.imageUrl,
          fit: BoxFit.cover,

        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          title: Text(
            mygame.xchange,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){},
          ),
        ),
    );
  }

}