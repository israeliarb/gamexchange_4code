import 'package:flutter/material.dart';
import '../models/xchange.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import 'package:gamexchange_4code/models/xchange.dart';
import 'package:gamexchange_4code/provider/xchanges.dart';
import 'package:provider/provider.dart';


class XchangeItem extends StatelessWidget{

  final Xchange myxchange;

  XchangeItem(this.myxchange);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.asset('assets/icons/xchange.png'
          //myxchange.imageUrl,
          //fit: BoxFit.cover,

        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(Icons.delete),
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
                  Provider.of<Xchanges>(context, listen: false).removerXchange(myxchange.id);
                }
              });
            },
          ),
          title: Text(
            myxchange.categoria,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.orange,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRotas.GAME_FORM,
                arguments: myxchange,
              );
            },
          ),
        ),
    );
  }

}