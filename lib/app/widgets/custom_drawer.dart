import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final User currentUser;

  const CustomDrawer({
    Key key,
    this.currentUser,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(currentUser.email),
            accountName: Text(currentUser.displayName),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(currentUser.photoURL),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Início"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.addchart),
            title: Text("Orçamento"),
            onTap: () {
              Navigator.popAndPushNamed(context, "/Orca");
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text("Tabela VRPO"),
            onTap: () {
              Navigator.popAndPushNamed(context, "/Vrpo");
            },
          ),
          ListTile(
            leading: Icon(Icons.addchart),
            title: Text("Relatórios"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Sair"),
            onTap: () {
              final FirebaseAuth _auth = FirebaseAuth.instance;
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
                          Navigator.pushNamedAndRemoveUntil(context, '/Login',
                              (Route<dynamic> route) => false);
                        }),
                    FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
