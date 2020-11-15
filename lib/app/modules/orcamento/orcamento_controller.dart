import 'dart:async';
import 'package:odontoplan/app/models/orcamento_model.dart';
import 'package:odontoplan/app/repositories/orcamento_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'orcamento_controller.g.dart';

@Injectable()
class OrcamentoController = _OrcamentoControllerBase with _$OrcamentoController;

abstract class _OrcamentoControllerBase with Store {
  final String _url = 'https://odontoplan2020.herokuapp.com/v1/graphql';

  HasuraConnect _hasuraConnect;

  HasuraConnect _conectaBase() {
    this._hasuraConnect = HasuraConnect(_url);
    return _hasuraConnect;
  }

  void desconectaBase() {
    if (_hasuraConnect.isConnected) _hasuraConnect.disconnect();
  }

  Future<List<OrcamentoModel>> consultaOrcamentos(String data) async {
    OrcamentoRepository categ = new OrcamentoRepository(_conectaBase());
    if (data == null)
      return await categ.getOrcamentos(getCurrentUser());
    else
      return await categ.getOrcamentosPorData(getCurrentUser(), data);
  }

  String getCurrentUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser.uid;
  }
}
