import 'dart:convert';

class CategoriaModel {
  int id;
  String descricao;

  CategoriaModel({this.id, this.descricao});

  factory CategoriaModel.fromMap(Map data) {
    return CategoriaModel(id: data['id'], descricao: data['descricao'] ?? '');
  }

  Map<String, dynamic> toMap() => {"id": id, "descricao": descricao};

  String toJson() => json.encode(toMap());

  factory CategoriaModel.fromJson(String source) =>
      CategoriaModel.fromMap(json.decode(source));

  static List<CategoriaModel> fromJsonList(List list) {
    return list
        .map<CategoriaModel>((item) => CategoriaModel.fromMap(item))
        .toList();
  }

  static List<CategoriaModel> fromList(List list) {
    return fromJsonList(list);
  }

  @override
  String toString() => 'CategoriaModel(id: $id, descricao: $descricao)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is CategoriaModel && o.id == id;
  }
}
