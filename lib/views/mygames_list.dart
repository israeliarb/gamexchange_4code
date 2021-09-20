import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import '../provider/games.dart';
import '../widgets/mygame_item.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/games.dart';
import 'package:gamexchange_4code/widgets/menu_lateral.dart';
import 'package:gamexchange_4code/widgets/mygame_item.dart';

class MyGameList extends StatefulWidget {
  //const GameOverviewScreen({Key? key}) : super(key: key);

  @override
  _MyGameListState createState() => _MyGameListState();
}


class _MyGameListState extends State<MyGameList> {
  Future<void> _refreshGames(BuildContext context) async {
    return Provider.of<Games>(context, listen: false).carregarGames();
  }

  void initState() {
    super.initState();
    Provider.of<Games>(context, listen: false).carregarGames();
  }

  @override
  Widget build(BuildContext context) {
    final Games games = Provider.of(context);
    final game = games.items;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            title: Center(
              child: Image.asset('assets/icons/gamexchange.png',
                  fit: BoxFit.contain, height: 40, alignment: Alignment.center),
            ),
            backgroundColor: Colors.grey[900],
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/game-form');
                },
              )
            ]),
        drawer: MenuLateral(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/icons/fundo.png'),
                fit: BoxFit.cover,
              ),
            ),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Meu Games",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[200],
                        fontFamily: 'Anton'),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 300,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 80 / 100,
                    child: RefreshIndicator(
                      onRefresh: () => _refreshGames(context),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: games.count,
                        itemBuilder: (ctx, i) => MyGameItem(game[i]),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 3 / 3,
                            mainAxisSpacing: 10),
                      ), /**/
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}