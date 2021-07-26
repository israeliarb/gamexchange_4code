import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/game.dart';
import '../widgets/game_item.dart';

class GameOverviewScreen extends StatelessWidget {
  //const GameOverviewScreen({Key? key}) : super(key: key);

  final List<Game> loadedGames = DUMMY_GAMES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/icons/fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  icon: Icon(Icons.menu),
                                  color: Colors.white,
                                  onPressed: (){},
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
                                      icon: Icon(Icons.account_box),
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
              SizedBox(height: 20,),
              Container( //cria as listas por usuário
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              //borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "User: Yunikko",
                                    style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[200],
                                    fontFamily: 'Anton'
                                  ),
                                ),
                                /*Text(
                                  "Jogos",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[200],
                                      fontFamily: 'Lato'
                                  ),
                                ),*/
                                SizedBox(height: 5,),
                                Container(
                                  height: 250,
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    //padding: const EdgeInsets.all(10),
                                    itemCount: loadedGames.length,
                                    itemBuilder: (ctx, i) => GameItem(loadedGames[i]),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        //maxCrossAxisExtent: 200,
                                        childAspectRatio: 4 / 3 ,
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
              Container( //cria as listas por usuário
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          //borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "User: Iarb",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[200],
                                  fontFamily: 'Anton'
                              ),
                            ),
                            /*Text(
                              "Jogos",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[200],
                                  fontFamily: 'Lato'
                              ),
                            ),*/
                            SizedBox(height: 5,),
                            Container(
                              height: 250,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                //padding: const EdgeInsets.all(10),
                                itemCount: loadedGames.length,
                                itemBuilder: (ctx, i) => GameItem(loadedGames[i]),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    //maxCrossAxisExtent: 200,
                                    childAspectRatio: 4 / 3 ,
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
              Container( //cria as listas por usuário
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          //borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "User: Iarb",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[200],
                                  fontFamily: 'Anton'
                              ),
                            ),
                            /*Text(
                              "Jogos",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[200],
                                  fontFamily: 'Lato'
                              ),
                            ),*/
                            SizedBox(height: 5,),
                            Container(
                              height: 250,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                //padding: const EdgeInsets.all(10),
                                itemCount: loadedGames.length,
                                itemBuilder: (ctx, i) => GameItem(loadedGames[i]),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    //maxCrossAxisExtent: 200,
                                    childAspectRatio: 4 / 3 ,
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

/*
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