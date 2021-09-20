import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  //List<Game> loadedGames = DUMMY_GAMES;
  List<Game> loadedGames;
  Map<String, dynamic> item;

  var aux;

  List<Game> jogoAux;

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
    //getCurrentLocation(context);
    Users lista = users.getOrdenado(context);
    //List<Game> loadedGames;
    //Provider.of<Games>(context, listen: false).carregarUserGames();

    var carregarUserGames = Provider.of<Games>(context, listen: false).carregarUserGames();

    List<Games> userGames;
    carregarUserGames.then((value) => {
      item = value,
      //loadedGames.add(item.values.first.toString()),
      print(item.values.first),
      aux = item[0],
      jogoAux = aux.split(","),
      item.values.forEach((element) {
        //aux = item.values.first;
        //jogoAux = aux.split(",");
        //loadedGames.add(jogoAux);
      }),
      //loadedGames.add(string.split()),
      print(item.values.first)
    });

    //Games games = getUserGameList(context);

    //List<Game> loadedGames = games.items;

    return StatefulWrapper(
      onInit: () {
        getCurrentLocation(context);
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
          /*actions: <Widget> [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, );
                },
                icon: Icon(Icons.account_box, size: 20, color: Colors.white),
              ),
            ],*/
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
                                lista.items[2].nickname,
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
                                  itemCount: item != null? item.length:0,
                                  //itemCount: item,
                                  //itemCount: loadedGames.length,
                                  itemBuilder: (ctx, i) =>
                                      //GameItem(loadedGames[i]),
                                      //GameListItem(item.values.first[i]),
                                      //GameItem(item.values.first[i]),
                                      GameItem(item.values.first[i]),
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
                  ),
                ),*/
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
