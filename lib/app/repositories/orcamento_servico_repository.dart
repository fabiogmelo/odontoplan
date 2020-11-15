import 'package:hasura_connect/hasura_connect.dart';
import 'package:odontoplan/app/models/servico_orcamento_model.dart';

class ServicosOrcamentoRepository {
  final HasuraConnect _hasuraConnect;

  ServicosOrcamentoRepository(this._hasuraConnect);

  Future<List<ServicoOrcamentoModel>> getServicosOrcamento(
      int orcamento) async {
    var query = ''' 
          query MyServicosOrcamentos {
            servico_orcamento(where: {id_orcamento: {_eq: $orcamento}}) {
              id_orcamento
              id_servico
              qtde
              servico {
                descricao
                preco
              }
            }
          }
          ''';
    var snapshot = await _hasuraConnect.query(query);
    return ServicoOrcamentoModel.fromList(
        snapshot['data']['servico_orcamento']);
  }

  Future<void> addServicoOrcamento(ServicoOrcamentoModel orcamento) async {
    var mutation = r''' 
            mutation addServicoOrcamento($id_orcamento: Int, $id_servico: Int, $qtde: Int) {
              insert_servico_orcamento(objects: {id_orcamento: $id_orcamento, id_servico: $id_servico, qtde: $qtde}) {
                affected_rows
              }
            }
    ''';

    _hasuraConnect.mutation(mutation, variables: {
      "id_orcamento": orcamento.idOrcamento,
      "id_servico": orcamento.idServico,
      "qtde ": orcamento.qtde,
    });
  }
}
