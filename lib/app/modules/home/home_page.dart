import 'package:odontoplan/app/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';
import 'package:koukicons/editDoc.dart';
import 'package:koukicons/exitDoor2.dart';
import 'package:koukicons/dataSheet.dart';
import 'package:koukicons/docFolder.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Odonto Plan"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        primary: false,
        slivers: <Widget>[
          SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              sliver: SliverGrid.count(
                  childAspectRatio: 1.5,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/consultorio.png',
                        alignment: Alignment.center,
                      ),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2)
                          ]),
                    ),
                  ])),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            sliver: SliverGrid.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: KoukiconsEditDoc(),
                    onPressed: () => {Navigator.pushNamed(context, "/Orca")},
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                ),
                Container(
                  child: IconButton(
                      icon: KoukiconsDataSheet(
                        width: 80,
                      ),
                      onPressed: () => {Navigator.pushNamed(context, "/Vrpo")}),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                ),
                Container(
                  child: IconButton(
                    icon: KoukiconsDocFolder(),
                    onPressed: () {},
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                ),
                Container(
                  child: IconButton(
                    icon: KoukiconsExitDoor2(width: 70),
                    onPressed: () => {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text("Sair"),
                          content: Text("Deseja realmente sair da aplicação?"),
                          actions: [
                            FlatButton(
                                child: Text("Sim"),
                                onPressed: () async {
                                  await _auth.signOut();
                                  if (_auth.currentUser == null)
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/Login',
                                        (Route<dynamic> route) => false);
                                }),
                            FlatButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    },
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),

      /*Container(
        padding: EdgeInsets.only(top: 200, right: 50, left: 50),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 82, 82, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () =>
                              {Navigator.pushNamed(context, "/Orca")},
                          padding: EdgeInsets.all(.1),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.addchart, color: Colors.white),
                              Text(
                                "Orçamento",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 82, 82, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () =>
                              {Navigator.pushNamed(context, "/Vrpo")},
                          padding: EdgeInsets.all(.1),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.attach_money, color: Colors.white),
                              Text(
                                "Tabela VRPO",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 82, 82, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.all(.1),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.attach_money, color: Colors.white),
                              Text(
                                "Relatórios",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 82, 82, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () => {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text("Sair"),
                                content:
                                    Text("Deseja realmente sair da aplicação?"),
                                actions: [
                                  FlatButton(
                                      child: Text("Sim"),
                                      onPressed: () async {
                                        await _auth.signOut();
                                        if (_auth.currentUser == null)
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/Login',
                                              (Route<dynamic> route) => false);
                                      }),
                                  FlatButton(
                                      child: Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              ),
                            ),
                          },
                          padding: EdgeInsets.all(.1),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.power_settings_new,
                                  color: Colors.white),
                              Text(
                                "Sair",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      */
      drawer: Observer(
        builder: (_) {
          return CustomDrawer(currentUser: controller.currentUser);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.getCurrentUser();
  }
}
