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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game - Cadastro'),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                final isValid = _form.currentState.validate();

                if (isValid) {
                  _form.currentState.save();

                  final game = Game(
                    id: _formData['id'],
                    nome: _formData['nome'],
                    xchange: _formData['xchange'],
                    plataforma: _formData['plataforma'],
                    estado: _formData['estado'],
                    imageUrl: _formData['imageUrl'],
                  );

                  setState(() {
                    _isLoading = true;
                  });

                  final games = Provider.of<Games>(context, listen: false);

                  try {
                    if (_formData['id'] == null) {
                      await games.adicionarGame(game);
                    } else {
                      await games.atualizarGame(game);
                    }
                    Navigator.of(context).pop();
                  } catch (error) {
                    await showDialog<Null>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Ocorreu um erro!'),
                        content: Text('Ocorreu um erro pra salvar o jogo'),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text('Fechar'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                  // Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),




        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _form,
                child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: _formData['nome'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.album),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Nome do jogo',
                    ),
                    validator: (value) {
                      // ignore: missing_return
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo nome em branco';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['nome'] = value,
                  ),


                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: _formData['plataforma'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.videogame_asset),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Plataforma',
                    ),
                    validator: (value) {
                      // ignore: missing_return
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo plataforma em branco';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['plataforma'] = value,
                  ),


                  TextFormField(
                    initialValue: _formData['estado'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.arrow_drop_down),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Estado de conservação',
                    ),
                    validator: (value) {
                      // ignore: missing_return
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo estado em branco';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['estado'] = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  TextFormField(
                    initialValue: _formData['xchange'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.arrow_drop_down),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Tipo de xchange',
                    ),
                    validator: (value) {
                      // ignore: missing_return
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo xchange em branco';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['xchange'] = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  TextFormField(
                    initialValue: _formData['imageUrl'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.image),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Url Imagem',
                    ),
                    onSaved: (value) => _formData['imageUrl'] = value,
                  ),
                  SizedBox(
                    height: 40,
                  ),


                ]
                )
            )
        )
    );
  }
}