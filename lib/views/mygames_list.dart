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


//---------------------------------------------------------------------------------------
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';
import '../provider/games.dart';
import '../widgets/mygame_item.dart';
import 'package:provider/provider.dart';


class MyGameList extends StatelessWidget {

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<Games>(context, listen: false).carregarGames();
  }

  @override
  Widget build(BuildContext context) {
    final Games games = Provider.of(context);
    final game = games.items;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/icons/fundo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                        width: double.infinity,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            //borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50,

                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/game-overview-screen');
                                    },
                                  )
                                )
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/icons/gamexchange.png'),
                                          fit: BoxFit.scaleDown,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 50,

                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.white,
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/game-form');
                                        },
                                      )
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                          SingleChildScrollView(
                            child: Container(
                                //height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  //borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      "My Games",
                                        style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.grey[200],
                                        fontFamily: 'Anton'
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 300,
                                      height: MediaQuery.of(context).size.height * 80/100,

                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          //padding: const EdgeInsets.all(10),
                                          itemCount: games.count,
                                          itemBuilder: (ctx, i) => MyGameItem(game[i]),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              //maxCrossAxisExtent: 200,
                                              childAspectRatio: 3 / 3 ,
                                              mainAxisSpacing: 10
                                          ),

                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ),
                      ],

            ),
          ),

      ),

    );

    /*return Scaffold(
      appBar: AppBar(
        title: Text(
            'gameXchange'
        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: loadedGames.length,
          itemBuilder: (ctx, i) => GameItem(loadedGames[i]),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          )
      ),
    );*/
  }
}


actions: <Widget> [
  Padding(
    padding: EdgeInsets.all(10.0),
    child: Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(10)
    ),
    child: Center(
      child: Icon(Icons.account_box),
    ),
  ),
  )
]*/