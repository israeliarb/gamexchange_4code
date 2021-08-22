import 'package:flutter/material.dart';
import '../models/game.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import 'package:gamexchange_4code/models/game.dart';
import 'package:gamexchange_4code/provider/games.dart';
import 'package:provider/provider.dart';


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
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Game'),
                  content: Text('Tem certeza?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Não'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Sim'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              ).then((confimed) {
                if (confimed) {
                  Provider.of<Games>(context, listen: false).removerGame(mygame.id);
                }
              });
            },
          ),
          title: Text(
            mygame.xchange,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.orange,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRotas.GAME_FORM,
                arguments: mygame,
              );
            },
          ),
        ),
    );
  }

}