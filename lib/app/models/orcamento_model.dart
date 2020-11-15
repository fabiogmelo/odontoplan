class OrcamentoModel {
  String cliente;
  String idUsuario;
  String data;
  String plano;
  double valortotal;

  OrcamentoModel(this.cliente, this.idUsuario, this.data, this.plano,
      [this.valortotal = 0]);

  factory OrcamentoModel.fromMap(Map map) {
    double total = 0.0;
    for (int i = 0; i < map['orcamento']['servico_orcamentos'].length; i++) {
      total = total +
          map['orcamento']['servico_orcamentos'][i]['qtde'] *
              map['orcamento']['servico_orcamentos'][i]['servico']['preco'];
    }
    return OrcamentoModel(
        map['orcamento']['cliente'],
        map['orcamento']['usuario_id'],
        map['orcamento']['data'],
        map['orcamento']['plano_saude'],
        num.parse(total.toStringAsPrecision(6)).toDouble());
  }

  Map<String, dynamic> toMap() => {
        "cliente": cliente,
        "usuario_id": idUsuario,
        "data": data,
        'plano_saude': plano,
        "valortotal": valortotal
      };

  static List<OrcamentoModel> fromList(List list) {
    return fromJsonList(list);
  }

  static List<OrcamentoModel> fromJsonList(List list) {
    return list
        .map<OrcamentoModel>((item) => OrcamentoModel.fromMap(item))
        .toList();
  }
}
