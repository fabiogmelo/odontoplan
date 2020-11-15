import 'package:firebase_auth/firebase_auth.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:odontoplan/app/models/orcamento_model.dart';
import 'package:odontoplan/app/repositories/orcamento_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'inserir_orcamento_controller.g.dart';

@Injectable()
class InserirOrcamentoController = _InserirOrcamentoControllerBase
    with _$InserirOrcamentoController;

abstract class _InserirOrcamentoControllerBase with Store {
  final String _url = 'https://odontoplan2020.herokuapp.com/v1/graphql';
  HasuraConnect _hasuraConnect;

  User currentUser = FirebaseAuth.instance.currentUser;

  Future<int> insereOrcamento(
      String cliente, String idUsuario, String data, String plano) async {
    OrcamentoModel orcamento =
        new OrcamentoModel(cliente, idUsuario, data, plano);

    OrcamentoRepository usuRep = new OrcamentoRepository(conectaBase());

    return usuRep.addOrcamento(orcamento);
  }

  HasuraConnect conectaBase() {
    this._hasuraConnect = HasuraConnect(_url);
    return _hasuraConnect;
  }

  void desconectaBase() {
    if (_hasuraConnect.isConnected) _hasuraConnect.disconnect();
  }

  Future<void> setOrcamentoPrefs(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('orcamento', value);
  }
}
