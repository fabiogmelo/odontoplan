import 'package:odontoplan/app/models/categoria_model.dart';
import 'package:odontoplan/app/models/servico_model.dart';
import 'package:odontoplan/app/models/servico_orcamento_model.dart';
import 'package:odontoplan/app/repositories/categoria_repository.dart';

import 'package:odontoplan/app/repositories/orcamento_servico_repository.dart';
import 'package:odontoplan/app/repositories/servico_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'inserir_servico_controller.g.dart';

@Injectable()
class InserirServicoController = _InserirServicoControllerBase
    with _$InserirServicoController;

abstract class _InserirServicoControllerBase with Store {
  final String _url = 'https://odontoplan2020.herokuapp.com/v1/graphql';
  HasuraConnect _hasuraConnect;

  @observable
  String selectedCat;

  HasuraConnect conectaBase() {
    this._hasuraConnect = HasuraConnect(_url);
    return _hasuraConnect;
  }

  void desconectaBase() {
    if (_hasuraConnect.isConnected) _hasuraConnect.disconnect();
  }

  @action
  Future<List<CategoriaModel>> consultaCategorias() async {
    CategoriaRepository categ = new CategoriaRepository(conectaBase());
    return await categ.getCategorias();
  }

  @action
  Future<List<ServicoModel>> consultaServicosPorCategoria(
      String idCategoria) async {
    ServicoRepository serv = new ServicoRepository(conectaBase());
    return await serv.getServicosPorCategoria(idCategoria);
  }

  @action
  Future<List<ServicoOrcamentoModel>> consultaServicosPorOrcamento(
      int idOrcamento) async {
    ServicosOrcamentoRepository serv =
        new ServicosOrcamentoRepository(conectaBase());
    return await serv.getServicosOrcamento(idOrcamento);
  }

  @action
  Future<void> insereServicoOrcamento(
      int idOrcamento, int idServico, int qtde) async {
    ServicoOrcamentoModel servicoOrcamento =
        new ServicoOrcamentoModel(idOrcamento, idServico, qtde);

    ServicosOrcamentoRepository usuRep =
        new ServicosOrcamentoRepository(conectaBase());

    return usuRep.addServicoOrcamento(servicoOrcamento);
  }

  Future<int> getOrcamentoPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('orcamento');
  }
}
