import 'dart:convert';

class UsuarioModel {
  String id;
  String email;
  String nome;
  String photoUrl;

  UsuarioModel({this.id, this.email, this.nome, this.photoUrl});

  factory UsuarioModel.fromList(List data) {
    return UsuarioModel(
      id: data[0]['id'],
      email: data[0]['email'] ?? '',
      nome: data[0]['nome'] ?? '',
      photoUrl: data[0]['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() =>
      {"id": id, "email": email, "name": nome, "photoUrl": photoUrl};

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromList(json.decode(source));

  static List<UsuarioModel> fromJsonList(List list) {
    return list
        .map<UsuarioModel>((item) => UsuarioModel.fromList(item))
        .toList();
  }

  @override
  String toString() =>
      'UsuarioModel(id: $id, email: $email, nome: $nome, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UsuarioModel && o.id == id;
  }
}
