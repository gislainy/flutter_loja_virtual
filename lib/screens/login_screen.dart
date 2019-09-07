import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/models/user_model.dart';
import 'package:flutter_loja_virtual/screens/signup_screen.dart';
import "package:scoped_model/scoped_model.dart";
import "dart:async";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SingupScreen()));
            },
            child: Text("CRIAR CONTA",
                style: TextStyle(fontSize: 15.0, color: Colors.white)),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-email inválido";
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Informe o seu e-mail para recuperação"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          model.recoveryPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Verifique seu e-mail"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 3),
                          ));

                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        model.singIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                            onSucess: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Login efetuado com sucesso"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor:
                                  Theme
                                      .of(context)
                                      .primaryColor),

                              );
                              Future.delayed(Duration(seconds: 1)).then((_) {
                                Navigator.of(context).pop();
                              });
                            },
                            onFail: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Não foi possível efetuar o login"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor:
                                  Colors.redAccent),
                              );
                            });
                      }
                    },
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
