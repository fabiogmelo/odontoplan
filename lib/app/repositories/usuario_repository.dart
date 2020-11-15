import 'package:hasura_connect/hasura_connect.dart';
import '../models/usuario_model.dart';

class UsuarioRepository {
  final HasuraConnect _hasuraConnect;

  UsuarioRepository(this._hasuraConnect);

  Future<UsuarioModel> getUsuario(String id) async {
    var query = ''' 
            query getUsuario {
                usuario(where: {id: {_eq: "$id"}}) {
                  id
                  email
                  nome
                  photoUrl
                }
              }
           ''';

    var snapshot = await _hasuraConnect.query(query);

    return UsuarioModel.fromList(snapshot["data"]["usuario"]);
  }

  Future<bool> addUsuario(UsuarioModel usuario) async {
    var mutation = r''' 
    mutation addUsuario($id: String, $email: String, $nome: String, $photoUrl: String) {
                          insert_usuario(objects: {id: $id, email: $email, nome: $nome, photoUrl: $photoUrl}){
                            affected_rows
                          }
              }
    ''';

    var snapshot = await _hasuraConnect.mutation(mutation, variables: {
      "id": usuario.id,
      "email": usuario.email,
      "nome": usuario.nome,
      "photoUrl": usuario.photoUrl,
    });

    return snapshot["data"]["insert_usuario"]["affected_rows"] > 0;
  }
}
