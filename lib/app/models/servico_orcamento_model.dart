import 'dart:convert';

class ServicoOrcamentoModel {
  int idOrcamento;
  int idServico;
  int qtde;
  String descServico;
  double preco;

  ServicoOrcamentoModel(this.idOrcamento, this.idServico, this.qtde,
      [this.descServico = '', this.preco = 0]);

  factory ServicoOrcamentoModel.fromMap(Map map) {
    String x = map['servico']['descricao'];
    double y = map['servico']['preco'];

    ServicoOrcamentoModel z = new ServicoOrcamentoModel(
        map['id_orcamento'], map['id_servico'], map['qtde'], x, y);

    return z;
  }

  static List<ServicoOrcamentoModel> fromList(List list) {
    return fromJsonList(list);
  }

  static List<ServicoOrcamentoModel> fromJsonList(List list) {
    return list
        .map<ServicoOrcamentoModel>(
            (item) => ServicoOrcamentoModel.fromMap(item))
        .toList();
  }

  Map<String, dynamic> toMap() => {
        'id_orcamento': idOrcamento,
        'id_servico': idServico,
        'qtde': qtde,
        'descricao': descServico,
        'preco': preco
      };

  String toJson() => json.encode(toMap());
}
