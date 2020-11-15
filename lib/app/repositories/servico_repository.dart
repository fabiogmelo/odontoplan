import 'package:odontoplan/app/models/servico_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

@Injectable()
class ServicoRepository extends Disposable {
  final HasuraConnect _hasuraConnect;

  ServicoRepository(this._hasuraConnect);

  Future<List<ServicoModel>> getServicosPorCategoria(String id) async {
    var query = ''' 
            query ServicosPorCategoria {
              servico(where: {id_categoria: {_eq: $id}}, order_by: {id: asc}) {
                descricao
                id
                preco
              }
            }
           ''';

    var snapshot = await _hasuraConnect.query(query);
    return ServicoModel.fromList(snapshot['data']['servico']);
  }

  Future<List<ServicoModel>> getServicosPorOrcamento(String id) async {
    var query = ''' 
            query ServicosPorOrcamento {
              servico(where: {servico_orcamentos: {id_orcamento: {_eq: $id}}}) {
                servico_orcamentos {
                  qtde
                  servico {
                    descricao
                    preco
                  }
                }
              }
            }

           ''';

    var snapshot = await _hasuraConnect.query(query);
    return ServicoModel.fromList(snapshot['data']['servico']);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
