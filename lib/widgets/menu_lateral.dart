import 'package:flutter/material.dart';
import 'package:gamexchange_4code/routes/AppRotas.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
                  child: Image.asset('assets/icons/gamexchange.png'),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                  ),
              ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Início"),
            //trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, AppRotas.GAME);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
              leading: Icon(Icons.games),
              title: Text("Meus Jogos"),
              //trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, AppRotas.MY_GAMES);
              }),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text("Meus Xchanges"),
            //trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, AppRotas.MY_XCHANGES);
            },
          ),
        ],
      ),
    );
  }
}
