import 'package:odontoplan/app/models/categoria_model.dart';
import 'package:hasura_connect/hasura_connect.dart';

class CategoriaRepository {
  final HasuraConnect _hasuraConnect;

  CategoriaRepository(this._hasuraConnect);

  Future<List<CategoriaModel>> getCategorias() async {
    var query = ''' 
            query getCategorias {
                categoria {
                  id
                  descricao
                }
              }
           ''';

    var snapshot = await _hasuraConnect.query(query);
    return CategoriaModel.fromList(snapshot['data']['categoria']);
  }
}
