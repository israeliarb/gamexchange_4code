import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/models/gamelist.dart';
import 'package:gamexchange_4code/models/user.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import 'package:gamexchange_4code/provider/users.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import 'package:gamexchange_4code/widgets/user_item.dart';
import '../data/dummy_data.dart';
import '../models/game.dart';
import '../widgets/game_item.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/games.dart';
import 'package:gamexchange_4code/widgets/menu_lateral.dart';

class GameOverviewScreen extends StatelessWidget {
  //const GameOverviewScreen({Key? key}) : super(key: key);

  Position _currentPosition;

  //List<User> loadedUsers = DUMMY_USERS;

  List<Game> loadedGames = [];
  Game jogo;
  List<Game> userGameList = [];
  //Map<Game, dynamic> mapaJogos;
  //var teste;

  Map<String, dynamic> item;
  Map<String, dynamic> teste;

  List<String> userId = [];
  var aux;

  getCurrentLocation(BuildContext context) async {
    //if(getPermission() != 0){
    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);
    Auth _auth = Provider.of<Auth>(context, listen: false);
    Users _users = Provider.of<Users>(context, listen: false);


    User _user = _auth.currentUser;
    print(_user);
    _user.latitude = _currentPosition.latitude;
    _user.longitude = _currentPosition.longitude;
    _users.atualizarUser(_user);
  }

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of(context);
    Auth _auth = Provider.of<Auth>(context, listen: false);
    User _user = _auth.currentUser;
    Users lista = users.getOrdenado(context);

    var carregarUserGames = Provider.of<Games>(context, listen: false).carregarUserGames();

    var splitLista;
    carregarUserGames.then((value) =>
    {
      item = value,
      teste = item,
        teste.entries.forEach((unidade) {
          userId.add(unidade.key);
          teste.values.forEach((element) {
            aux = json.encode(element);
            //userId = item.values;
            splitLista = aux.split("}");

            splitLista.forEach((ocorrencia) {
              var splitJogo = ocorrencia.split("\"");
              String id = splitJogo[1];
              //String fkUser = splitJogo[9];
              String nome = splitJogo[13];
              String xchange = splitJogo[21];
              String plataforma = splitJogo[17];
              String estado = splitJogo[5];
              String imageUrl = splitJogo[9];

              jogo = new Game(
                  nome: nome,
                  xchange: xchange,
                  imageUrl: imageUrl,
                  plataforma: plataforma,
                  id: id,
                  estado: estado,
                  //fkUser: fkUser
              );

              userGameList.add(jogo);
              // userGameList.add(new Game(estado: splitJogo[3], plataforma: splitJogo[17], id: splitJogo[1], imageUrl: splitJogo[9], nome: splitJogo[13], xchange: splitJogo[21]));

            });
          });
        }),
        teste.removeWhere((key, value) => key == (userId[userId.length-1])),
        print(teste),

    });


    return StatefulWrapper(
      onInit: () {
        getCurrentLocation(context);
        carregarUserGames = Provider.of<Games>(context, listen: false).carregarUserGames();
        users.getOrdenado(context); //função que ordena a lista de usuários
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          title: Center(
            child: Image.asset('assets/icons/gamexchange.png',
                fit: BoxFit.contain, height: 40, alignment: Alignment.center),
          ),
          backgroundColor: Colors.grey[900],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.person, size: 20, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            )
          ],
        ),
        drawer: MenuLateral(),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  _user.nickname, //VERIFICAR COMO COLOCAR O NOME DO USUÁRIO
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[200],
                      fontFamily: 'Anton'),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Alterar Usuário"),
                onTap: () {
                  Navigator.pushNamed(context, AppRotas.REGISTRO);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sair"),
                  //trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, AppRotas.LOGIN);
                  }),
            ],
          ),
        ),
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
                SizedBox(
                  height: 20,
                ),
            /*Container(
                  //cria as listas por usuário
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
                          child: GridView.builder(
                            padding: EdgeInsets.all(5.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: lista.items.length,
                            itemBuilder: (ctx, i) => UserItem(lista.items[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/

                Container(
                  //cria as listas por usuário
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
                                lista.items[1].nickname,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[200],
                                    fontFamily: 'Anton'),
                              ),
                              SizedBox(
                                height: 5,
                              ),Text(
                                lista.items[1].telefone,
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
                                  itemCount: userGameList.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(userGameList[i]),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      //maxCrossAxisExtent: 200,
                                      childAspectRatio: 4 / 3,
                                      mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),Container(
                  //cria as listas por usuário
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
                                lista.items[2].nickname,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[200],
                                    fontFamily: 'Anton'),
                              ),
                              SizedBox(
                                height: 5,
                              ),Text(
                                lista.items[2].telefone,
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
                                  itemCount: userGameList.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(userGameList[i]),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      //maxCrossAxisExtent: 200,
                                      childAspectRatio: 4 / 3,
                                      mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),Container(
                  //cria as listas por usuário
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
                                lista.items[3].nickname,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[200],
                                    fontFamily: 'Anton'),
                              ),
                              SizedBox(
                                height: 5,
                              ),Text(
                                lista.items[3].telefone,
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
                                  itemCount: userGameList.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(userGameList[i]),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      //maxCrossAxisExtent: 200,
                                      childAspectRatio: 4 / 3,
                                      mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),Container(
                  //cria as listas por usuário
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
                                lista.items[4].nickname,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[200],
                                    fontFamily: 'Anton'),
                              ),
                              SizedBox(
                                height: 5,
                              ),Text(
                                lista.items[4].telefone,
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
                                  itemCount: userGameList.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(userGameList[i]),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      //maxCrossAxisExtent: 200,
                                      childAspectRatio: 4 / 3,
                                      mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ),Container(
                //   //cria as listas por usuário
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: Colors.grey[900],
                //             //borderRadius: BorderRadius.circular(15),
                //           ),
                //           child: Column(
                //             children: [
                //               Text(
                //                 lista.items[2].nickname,
                //                 style: TextStyle(
                //                     fontSize: 20,
                //                     color: Colors.grey[200],
                //                     fontFamily: 'Anton'),
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Container(
                //                 height: 250,
                //                 child: GridView.builder(
                //                   scrollDirection: Axis.horizontal,
                //                   //padding: const EdgeInsets.all(10),
                //                   itemCount: userGameList.length,
                //                   //itemCount: item != null? item.length:0,
                //                   //itemCount: item,
                //                   //itemCount: loadedGames.length,
                //                   itemBuilder: (ctx, i) =>
                //                       //GameItem(loadedGames[i]),
                //                       //GameListItem(item.values.first[i]),
                //                       //GameItem(item.values.first[i]),
                //                       GameItem(userGameList[i]),
                //                       //GameItem(jogo),
                //                       //GameItem(users.criaObjetoGame(item, aux, splitLista, jogo, userGameList)),
                //                   gridDelegate:
                //                   SliverGridDelegateWithFixedCrossAxisCount(
                //                       crossAxisCount: 1,
                //                       //maxCrossAxisExtent: 200,
                //                       childAspectRatio: 4 / 3,
                //                       mainAxisSpacing: 10),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                /*Container(
                  //cria as listas por usuário
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
                                    fontFamily: 'Anton'),
                              ),
                              /*Text(
                                "Jogos",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontFamily: 'Lato'
                                ),
                              ),*/
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 250,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  //padding: const EdgeInsets.all(10),
                                  itemCount: loadedGames.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(loadedGames[i]),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          //maxCrossAxisExtent: 200,
                                          childAspectRatio: 4 / 3,
                                          mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),*/
                //),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({@required this.onInit, @required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
/*
                 Container(
                  //cria as listas por usuário
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
                                    fontFamily: 'Anton'),
                              ),
                              /*Text(
                                "Jogos",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontFamily: 'Lato'
                                ),
                              ),*/
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 250,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  //padding: const EdgeInsets.all(10),
                                  itemCount: loadedGames.length,
                                  itemBuilder: (ctx, i) =>
                                      GameItem(loadedGames[i]),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          //maxCrossAxisExtent: 200,
                                          childAspectRatio: 4 / 3,
                                          mainAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
