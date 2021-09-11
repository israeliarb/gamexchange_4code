import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamexchange_4code/exceptions/auth_exception.dart';
import 'package:gamexchange_4code/models/user.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/provider/users.dart';



class RegistroCard extends StatefulWidget {

  @override
  _RegistroCardState createState() => _RegistroCardState();
}

class _RegistroCardState extends State<RegistroCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  final _cadastroData =  Map<String, Object>();
  final _passwordController = TextEditingController();

  void initState() {
    super.initState();
    Provider.of<Users>(context, listen: false);
  }
  @override
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),

              )
            ],
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    final deviceSize = MediaQuery.of(context).size;
        return Form(
        key: _form,

        child: Center(
          child: Container(
            height: double.infinity ,
            width: deviceSize.width * 0.70,
            color: Colors.black,
            child: SingleChildScrollView(
              child:Column(
              children:<Widget> [
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
                SizedBox(height: 20,),
                Padding( //nome
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Nome',
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty ) {
                        return "Ops! preencha este campo!";
                      }
                      return null;
                    },
                    onSaved: (value) => _cadastroData['nome'] = value,
                  ),
                ),
                SizedBox(height: 20,),
                Padding( //NickName
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.games),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Nickname',
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty ) {
                        return "Ops! preencha este campo!";
                      }
                      return null;
                    },
                    onSaved: (value) => _cadastroData['nickname'] = value,
                  ),
                ),
                SizedBox(height: 20,),
                Padding( //email
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Email',

                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')||!value.contains('.com')) {
                        return "Informe um e-mail válido!";
                      }
                      return null;
                    },
                    onSaved: (value) => _cadastroData['email'] = value ,
                  ),
                ),
                SizedBox(height: 20,),
                Padding( //email
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Telefone',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty || value.length < 11) {
                        return "Informe um Telefone válido!";
                      }
                      return null;
                    },
                    onSaved: (value) => _cadastroData['telefone'] = value,
                  ),
                ),
                SizedBox(height: 20,),
                Padding( //senha
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Senha',
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return "Informe uma senha válida!";
                      }
                      return null;
                    },
                    onSaved: (value) => _cadastroData['password']= value,
                  ),
                ),
                //SizedBox(height: 120,),
                SizedBox(height:20,),
                if(_isLoading)
                  CircularProgressIndicator()
                else
                  MaterialButton( //login
                    minWidth: 200, height:  40, color: Colors.orange,
                    shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.circular(20)),
                    child: Text("Cadastrar-me", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black)),

                    onPressed: () async{

                      final isValid = _form.currentState.validate();

                      if (isValid) {

                        _form.currentState.save();
                        final user = User(
                          id: _cadastroData['id'],
                          nome: _cadastroData['nome'],
                          nickname: _cadastroData['nickname'],
                          email: _cadastroData['email'],
                          telefone: _cadastroData['telefone'],
                          password: _cadastroData['password'],
                        );
                        setState(() {
                          _isLoading = true;
                        });

                        final users = Provider.of<Users>(context, listen: false);
                        try {
                          Auth auth = Provider.of(context, listen: false);
                          await auth.signup(_cadastroData['email'],    //salvando autenticação no banco
                            _cadastroData['password'],
                            context
                          );
                         if (_cadastroData['id'] == null) {
                            await users.adicionarUser(user);   //salvando usuário
                          } else{
                           await users.atualizarUser(user);
                         }
                          //Navigator.of(context).pop();
                        } on AuthException catch (error) {
                          _showErrorDialog(error.toString());
                        }catch (error) {
                          await showDialog<Null>(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: Text('Ocorreu um erro!'),
                                  content: Text('Ocorreu um erro pra salvar o usuário!'),
                                  actions: <Widget>[
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      child: Text('Fechar'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                          );
                        } finally{

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  minWidth: 200,
                  height:  40,
                  child: Text("Login", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                ),
              ],
            ),
          ),
    ),
    ),
    );
  }
}
