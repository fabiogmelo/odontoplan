import 'package:odontoplan/app/models/usuario_model.dart';
import 'package:odontoplan/app/repositories/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.transparent,
                radius: 60.0,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/default.png',
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 120.0,
                  ),
                )),
            Divider(),
            SignInButton(Buttons.Google, text: "Entre com o Google",
                onPressed: () async {
              var result = await controller.signInWithGoogle();
              if (result) {
                if (await insereUsuario())
                  Navigator.pushReplacementNamed(context, '/Home');
              } else {
                showDialog(
                    context: context,
                    child: AlertDialog(
                        content: Text(controller.mErro),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Fechar"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ]));
              }
            }),
            SignInButton(Buttons.Twitter, text: "Entre com o Twitter",
                onPressed: () async {
              var result = await controller.signInWithTwitter();
              if (result) {
                if (await insereUsuario())
                  Navigator.pushReplacementNamed(context, '/Home');
              } else {
                showDialog(
                    context: context,
                    child: AlertDialog(
                        content: Text(controller.mErro),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Fechar"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ]));
              }
            }),
            SignInButton(Buttons.Facebook,
                text: "Entre com o Facebook", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Future<bool> insereUsuario() async {
    User current = controller.currentUser;
    UsuarioModel usuario = new UsuarioModel(
        id: current.uid,
        nome: current.displayName,
        email: current.email ?? '',
        photoUrl: current.photoURL);

    UsuarioRepository usuRep = new UsuarioRepository(controller.conectaBase());

    if (usuario == await usuRep.getUsuario(current.uid)) {
      return true;
    } else
      usuRep.addUsuario(usuario);
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    controller.desconectaBase();
  }
}
