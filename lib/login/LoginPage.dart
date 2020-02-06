
import 'package:flutter/material.dart';
import 'package:the_app/widget/CircularProgressButton.dart';
import 'package:the_app/widget/FextFormField.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();


    //Deixa preenchido caso não deslogue
    //if(user != null){
    //setState(() {
    //_tLogin.text = user.login;
    //});
    //}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("THE APP"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 200,),
              TextFormFieldCustomize(
                  "Login", "Digite o login", controller: _tLogin,
                  validator: _validateLogin,
                  textInputAction: TextInputAction.next,
                  nextFocus: _focusSenha),
              SizedBox(height: 10,),
              TextFormFieldCustomize("Senha", "Digite a senha", obsText: true,
                  controller: _tSenha,
                  validator: _validateSenha,
                  keyboardType: TextInputType.number,
                  focusNode: _focusSenha),
              SizedBox(height: 20,),
              Container(
                height: 46,
                child: CircularProgressButton(
                    "Login", onPressed: () => _onClickLogin(),
                    showProgress: false),),
            ],
          ),
        )
    );
  }

  _onClickLogin() async {
    print("Login: TODO");
    Navigator.pushNamed(context, "/home");
  }

  String _validateLogin(String text){
    if(text.isEmpty){
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text){
    if(text.isEmpty){
      return "Digite a senha";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
