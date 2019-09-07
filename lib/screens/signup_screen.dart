import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class SingupScreen extends StatefulWidget {
  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome completo"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
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
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Endereço"),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválida";
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          };
                          model.singUp(
                              userData: userData,
                              password: _passwordController.text,
                              onSuccess: () {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text("Usuário criado com Sucesso!"), backgroundColor: Theme.of(context).primaryColor, duration: Duration(seconds: 2))
                                );
                                Future.delayed(Duration(seconds: 2)).then((_) {
                                  Navigator.of(context).pop();
                                });
                              },
                              onFail: () {
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text("Falha ao criar usuário!"), backgroundColor: Colors.redAccent, duration: Duration(seconds: 2))
                                );
                              });
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Criar conta",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
        }
      }),
    );
  }
}
