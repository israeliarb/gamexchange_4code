import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';
import '../data/dummy_xchange.dart';
import '../models/game.dart';
import '../models/xchange.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/xchanges.dart';
import 'package:gamexchange_4code/widgets/xchange_item.dart';

class XchangeRecebidos extends StatefulWidget {
  //const GameOverviewScreen({Key? key}) : super(key: key);

  @override
  _XchangeRecebidosState createState() => _XchangeRecebidosState();
}


class _XchangeRecebidosState extends State<XchangeRecebidos> {
  final List<Xchange> loadedXchanges = DUMMY_GAMES;
  Future<void> _refreshXchanges(BuildContext context) async {
    return Provider.of<Xchanges>(context, listen: false).carregarXchanges();
  }

  void initState() {
    super.initState();
    Provider.of<Xchanges>(context, listen: false).carregarXchanges();
  }

  @override
  Widget build(BuildContext context) {
    final Xchanges xchanges = Provider.of(context);
    final xchange = xchanges.items;

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
                    leading: Icon(Icons.home),
                    title: Text("Início"),
                    //trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(context, AppRotas.GAME);
                    })
              ],
            )),
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
                    "Meu Xchanges",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[200],
                        fontFamily: 'Anton'),
                  ),
                  SizedBox(height: 5),
                  /*Container(
                    width: 300,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 80 / 100,
                    child: RefreshIndicator(
                      onRefresh: () => _refreshXchanges(context),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: loadedXchanges.length,
                        itemBuilder: (ctx, i) => XchangeItem(loadedXchanges[i]),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 3 / 3,
                            mainAxisSpacing: 10),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ),
        ));
  }
}