import 'package:odontoplan/app/models/orcamento_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

@Injectable()
class OrcamentoRepository extends Disposable {
  final HasuraConnect _hasuraConnect;

  OrcamentoRepository(this._hasuraConnect);

  Future<List<OrcamentoModel>> getOrcamentos(String idUsuario) async {
    var query = ''' 
            query MeusOrcamentos {
              servico_orcamento_aggregate(where: {orcamento: {usuario_id: {_eq: "$idUsuario"}}}, distinct_on: id_orcamento) {
                  nodes {
                    orcamento {
                      cliente
                      data
                      servico_orcamentos {
                        qtde
                        servico {
                          preco
                        }
                      }
                    }
                  }
              }
            }

           ''';

    var snapshot = await _hasuraConnect.query(query);
    return OrcamentoModel.fromList(
        snapshot['data']['servico_orcamento_aggregate']['nodes']);
  }

  Future<List<OrcamentoModel>> getOrcamentosPorData(
      String idUsuario, String data) async {
    var query = ''' 
          query MeusOrcamentosPorData {
              servico_orcamento_aggregate(where: {orcamento: {usuario_id: {_eq: "$idUsuario"}, data: {_eq: "$data"}}}, distinct_on: id_orcamento) {
                nodes {
                  orcamento {
                    cliente
                    data
                    servico_orcamentos {
                      qtde
                      servico {
                        preco
                      }
                    }
                  }
                }
              }
          }
           ''';

    var snapshot = await _hasuraConnect.query(query);
    return OrcamentoModel.fromList(
        snapshot['data']['servico_orcamento_aggregate']['nodes']);
  }

  Future<int> addOrcamento(OrcamentoModel orcamento) async {
    var mutation = r''' 
          mutation addOrcamento ($cliente: String, $data: date, $plano_saude: String, $usuario_id: String){
          insert_orcamento(objects: {cliente: $cliente, data: $data, plano_saude: $plano_saude, usuario_id:  $usuario_id}) {
            returning {
              id
            }
          }
        }
    ''';

    var snapshot = await _hasuraConnect.mutation(mutation, variables: {
      "cliente": orcamento.cliente,
      "data": orcamento.data,
      "plano_saude": orcamento.plano,
      "usuario_id": orcamento.idUsuario,
    });

    return snapshot["data"]["insert_orcamento"]["returning"][0]["id"];
  }

  @override
  void dispose() {}
}
