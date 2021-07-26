import 'package:flutter/material.dart';
import 'package:gamexchange_4code/models/game.dart';
import 'package:gamexchange_4code/provider/games.dart';
import 'package:provider/provider.dart';

class GameForm extends StatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final _formData = Map<String, Object>();

  void initState(){
    super.initState();
    Provider.of<Games>(context, listen: false).carregarGames();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Game game = ModalRoute.of(context).settings.arguments;
    _loadFormData(game);
  }

  void _loadFormData(Game game) {
    if (game != null) {
      _formData['id'] = game.id;
      _formData['nome'] = game.nome;
      _formData['xchange'] = game.xchange;
      _formData['plataforma'] = game.plataforma;
      _formData['estado'] = game.estado;
      _formData['imageUrl'] = game.imageUrl;
    }
  }

  String nomePlataforma="";
  var _consoles =['','DreamCast','Game Gear','Game Cube','Game Boy','Master System','Nintendo 3DS','Nintendo 64','Nintendo Switch','Nintendo Wii','PlayStation 1','PlayStation 2','PlayStation 3','PlayStation 4','PlayStation 5','PSP','Xbox','Xbox 360','Xbox One','Xbox Series X/S'];
  var _itemSelecionado = '';

  void _dropDownItemSelected(String novoItem){
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: Colors.grey[900],
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
                        height: 100,
                        width: 125,
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
                      Padding( //nome
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
                      Padding( //plataforma
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
                      Padding( //estado
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
                      Padding( //xchange
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
                      SizedBox(height: 20,),
                      Padding( //game url
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.image),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: 'Url Imagem',
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

