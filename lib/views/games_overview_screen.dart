import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import '../data/dummy_data.dart';
import '../models/game.dart';
import '../widgets/game_item.dart';
import 'package:geolocator/geolocator.dart';

class GameOverviewScreen extends StatelessWidget {
  //const GameOverviewScreen({Key? key}) : super(key: key);

  Position _currentPosition;

  final List<Game> loadedGames = DUMMY_GAMES;

  getCurrentLocation() async{
    //if(getPermission() != 0){
      _currentPosition = await Geolocator.getCurrentPosition();
      print(_currentPosition);
    //}

  }

  /*getPermission() async {
    final GeolocationResult result =
    await Geolocation.requestLocationPermission(
        permission: const LocationPermission(
            android: LocationPermissionAndroid.fine,
            ios: LocationPermissionIOS.always));
    return result;
  }*/

  @override
  Widget build(BuildContext context) {

    return StatefulWrapper(
      onInit: (){
        getCurrentLocation();
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            title: Center(
              child: Image.asset('assets/icons/gamexchange.png',
                  fit: BoxFit.contain, height: 40,  alignment: Alignment.center),
            ),
            backgroundColor: Colors.grey[900],
            actions: <Widget> [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.account_box, size: 20, color: Colors.white),
              ),
            ]),

        drawer: Drawer(
            child: ListView(
              children: <Widget>[
                /*DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                  ),
                ),*/
                SizedBox(
                  height: 20,
                ),
                ListTile(
                    leading: Icon(Icons.games),
                    title: Text("Meus Jogos"),
                    //trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRotas.MY_GAMES);
                    }
                )
              ],
            )
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
                                "User: Yunikko",
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
                ),
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
                ),
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
                ),
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
    if(widget.onInit != null) {
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
