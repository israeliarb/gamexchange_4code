import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:gamexchange_4code/exceptions/auth_exception.dart';
import 'package:gamexchange_4code/provider/auth.dart';
import 'package:gamexchange_4code/provider/users.dart';
import 'package:gamexchange_4code/widgets/registro_card.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;

  final _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    Auth auth = Provider.of(context, listen: false);
    try {
      await auth.login(_authData["email"], _authData["password"], context);

      Navigator.pushNamed(context, '/game-overview-screen');
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("Ocorreu um erro inesperado!");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Form(
        key: _form,
        child: Center(
          child: Container(
            height: double.infinity,
            width: deviceSize.width * 0.70,
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/icons/gamexchange.png'),
                      fit: BoxFit.scaleDown,
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    //email
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return "Informe um e-mail válido!";
                        }
                        return null;
                      },
                      onSaved: (value) => _authData['email'] = value,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    //senha
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      autofocus: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Senha',
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return "Informe uma senha válida!";
                        }
                        return null;
                      },
                      onSaved: (value) => _authData['password'] = value,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    MaterialButton(
                      //login
                      minWidth: 200,
                      height: 40,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      onPressed: _submit,
                    ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      minWidth: 200,
                      height: 40,
                      child: Text("Cadastre-se",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18)),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/registro-card')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
