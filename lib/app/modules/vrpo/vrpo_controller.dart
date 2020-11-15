import 'package:odontoplan/app/models/categoria_model.dart';
import 'package:odontoplan/app/models/servico_model.dart';
import 'package:odontoplan/app/repositories/categoria_repository.dart';
import 'package:odontoplan/app/repositories/servico_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'vrpo_controller.g.dart';

@Injectable()
class VrpoController = _VrpoControllerBase with _$VrpoController;

abstract class _VrpoControllerBase with Store {
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
  Future<List<ServicoModel>> consultaServicosPorOrcamento(
      String idOrcamento) async {
    ServicoRepository serv = new ServicoRepository(conectaBase());
    return await serv.getServicosPorOrcamento(idOrcamento);
  }
}
