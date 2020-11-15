import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  //use 'controller' variable to access controller
  startTimeout() {
    return Timer(Duration(seconds: 1), changeScreen);
  }

  changeScreen() async {
    if (controller.currentUser != null) {
      Navigator.pushReplacementNamed(context, '/Home');
    } else {
      Navigator.pushReplacementNamed(context, '/Login');
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getCurrentUser();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Image(image: AssetImage('assets/images/dente.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
