/*
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math show pi;
import 'package:flutter/material.dart';

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem> _items;
  String _headline;
  NetworkImage _avatarImg = NetworkImage("");

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Orçamento',
        icon: Icons.assessment,
        onPressed: () {},
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Tabela de Preços',
        icon: Icons.attach_money,
        onPressed: () {},
      ),
      CollapsibleItem(
        text: 'Sair',
        icon: Icons.logout,
        onPressed: () {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Logout"),
              content: Text("Deseja realmente sair da aplicação?"),
              actions: [
                FlatButton(
                    child: Text("Continuar"),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Login', (Route<dynamic> route) => false);
                    }),
                FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        items: _items,
        avatarImg: _avatarImg,
        title: 'John Smith',
        body: _body(size, context),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Transform.translate(
            offset: Offset(-size.height * 0.3, -size.width * 0.23),
            child: Text(
              _headline,
              style: Theme.of(context).textTheme.headline1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
*/
