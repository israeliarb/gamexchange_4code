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

  void initState() {
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

  var _xchange = [
    'Troca Permanente',
    'Troca Temporária',
    'Venda'
  ];
  var _estado= [
    'Novo',
    'Semi-novo',
    'Usado'
  ];
   var _consoles = [
    'DreamCast',
    'Game Gear',
    'Game Cube',
    'Game Boy',
    'Master System',
    'Nintendo 3DS',
    'Nintendo 64',
    'Nintendo Switch',
    'Nintendo Wii',
    'PlayStation 1',
    'PlayStation 2',
    'PlayStation 3',
    'PlayStation 4',
    'PlayStation 5',
    'PSP',
    'Xbox',
    'Xbox 360',
    'Xbox One',
    'Xbox Series X/S',
     'Outros'
  ];

  var _itemSelecionado = '';

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          onPressed: () {
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
          child: Center(
            child: Container(
              width: 300,
              height: double.infinity,
              color: Colors.black,
              //),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 125,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/icons/gamexchange.png'),
                      fit: BoxFit.scaleDown,
                    )),
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
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                          key: _form,
                          child: Column(children: <Widget>[
                            TextFormField(
                              initialValue: _formData['nome'],
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.album),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
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

                            //plataforma
                            DropdownButtonFormField<String>(
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
                                    labelText: 'Plataforma'),
                                items:
                                    _consoles.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String novoItemSelecionado) {
                                  _dropDownItemSelected(novoItemSelecionado);
                                  setState(() {
                                    this._formData['plataforma'] =
                                        novoItemSelecionado;
                                  });
                                },
                              validator: (value) {
                              // ignore: missing_return
                              if (value == null || value.trim().isEmpty) {
                                return 'Campo plataforma em branco';
                              }
                              return null;
                            },
                              onSaved: (value) => _formData['plataforma'] = value,
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //Estado
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.auto_fix_high),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: 'Estado'),
                              items:
                              _estado.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String novoItemSelecionado) {
                                _dropDownItemSelected(novoItemSelecionado);
                                setState(() {
                                  this._formData['estado'] =
                                      novoItemSelecionado;
                                });
                              },
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

                            //Xchange
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.auto_awesome), /*Image.asset('assets/icons/xchange.png')*/
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: 'Xchange'),
                              items:
                              _xchange.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String novoItemSelecionado) {
                                _dropDownItemSelected(novoItemSelecionado);
                                setState(() {
                                  this._formData['xchange'] =
                                      novoItemSelecionado;
                                });
                              },
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

                            //Imagem URL
                            TextFormField(
                              initialValue: _formData['imageUrl'],
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.image),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
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
                          ]))),
                  MaterialButton(
                    //Confirmar
                    minWidth: 200,
                    height: 40,
                    color: Colors.orange,
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

                        final games =
                            Provider.of<Games>(context, listen: false);

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
                              content:
                                  Text('Ocorreu um erro pra salvar o jogo'),
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
                    shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Confirmar",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
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
