import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InsertGameOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
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
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child:
          Center(
            child:
                  Container(
                    width:300,
                    height: double.infinity,
                    color: Colors.black,
                  //),
                    child:
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/gamexchange.png'),
                              fit: BoxFit.scaleDown,
                            )
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/controller.png'),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                      ),
                      SizedBox(height: 30,),
                      Padding( //email
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.album),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Nome do jogo',
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding( //email
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.videogame_asset),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Plataforma',
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding( //email
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.arrow_drop_down),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Estado de conservação',
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding( //email
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.arrow_drop_down),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Tipo de xchange',
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      MaterialButton( //Confirmar
                        minWidth: 200,
                        height:  40,
                        color: Colors.orange,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("Confirmar", style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18
                        ),),
                      ),
                    ],
                  ),
              ),
           ),
        ),
      ),
    );

    }
}