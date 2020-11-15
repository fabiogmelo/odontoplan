import 'dart:convert';

class ServicoModel {
  int id;
  String descricao;
  String preco;

  ServicoModel({this.id, this.descricao, this.preco});

  factory ServicoModel.fromMap(Map map) {
    return ServicoModel(
        id: map['id'],
        descricao: map['descricao'],
        preco: map['preco'].toString());
  }

  static List<ServicoModel> fromList(List list) {
    return fromJsonList(list);
  }

  static List<ServicoModel> fromJsonList(List list) {
    return list
        .map<ServicoModel>((item) => ServicoModel.fromMap(item))
        .toList();
  }

  Map<String, dynamic> toMap() => {"id": id, "descricao": descricao};

  String toJson() => json.encode(toMap());
}
