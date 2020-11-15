import 'package:odontoplan/app/models/servico_model.dart';
import 'package:odontoplan/app/models/servico_orcamento_model.dart';
import 'package:odontoplan/app/modules/orcamento/relatorio/relatorio_gera_pdf.dart';
import 'package:odontoplan/app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:odontoplan/app/widgets/custom_text_field.dart';
import 'inserir_servico_controller.dart';

class InserirServicoPage extends StatefulWidget {
  final String title;
  const InserirServicoPage({Key key, this.title = "Inserir Servico"})
      : super(key: key);

  @override
  _InserirServicoPageState createState() => _InserirServicoPageState();
}

class _InserirServicoPageState
    extends ModularState<InserirServicoPage, InserirServicoController> {
  //use 'controller' variable to access controller

  final _formKey = GlobalKey<FormState>();

  int idOrcamento;
  int selectedIdServ;
  String selectedIdCat;
  String preco;
  int qtde = 1;

  List<ServicoModel> servicos = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: CustomScrollView(shrinkWrap: true, primary: false, slivers: <
                Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
                sliver: SliverGrid.count(
                  childAspectRatio: 5,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Container(
                        child: FutureBuilder(
                            future: controller.consultaCategorias(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CustomDropdown(
                                  labelText: 'Categorias',
                                  menuOptions: snapshot.data,
                                  update: (String value) async {
                                    selectedIdCat = value;
                                    servicos = await controller
                                        .consultaServicosPorCategoria(value);
                                    setState(() {});
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                sliver: SliverGrid.count(
                  childAspectRatio: 5,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Serviços',
                          border: OutlineInputBorder(),
                        ),
                        value: servicos.isEmpty
                            ? null
                            : servicos.first.id.toString(),
                        isExpanded: true,
                        items: servicos
                            .map((data) => DropdownMenuItem<String>(
                                  child: Text(data.descricao),
                                  value: data.id.toString(),
                                ))
                            .toList(),
                        onChanged: (String value) {
                          setState(() {
                            selectedIdServ = num.parse(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
                  sliver: SliverGrid.count(
                      childAspectRatio: 3,
                      crossAxisCount: 2,
                      children: <Widget>[
                        CustomTextField(
                          readOnly: false,
                          messageValidator: 'Quantidade invalida',
                          labelText: 'Quantidade',
                          onChanged: (String value) {
                            qtde = num.parse(value);
                          },
                          initialValue: '1',
                          keyboardType: TextInputType.number,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          // this will take space as minimum as posible(to center)
                          children: <Widget>[
                            new ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  //int id = await controller.getOrcamentoPrefs();
                                  controller.insereServicoOrcamento(
                                      idOrcamento, selectedIdServ, qtde);
                                }
                              },
                              child: Text('Adicionar'),
                            ),
                          ],
                        )
                      ])),
              SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  sliver: SliverGrid.count(
                      childAspectRatio: 1,
                      crossAxisCount: 1,
                      children: <Widget>[
                        Container(
                            child: FutureBuilder(
                                future: controller
                                    .consultaServicosPorOrcamento(idOrcamento),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView(
                                        padding: const EdgeInsets.all(16),
                                        children: [
                                          Container(
                                            child: PaginatedDataTable(
                                              header: Text('Serviços'),
                                              rowsPerPage: 3,
                                              columns: [
                                                DataColumn(
                                                    label: Text('Servico')),
                                                DataColumn(
                                                    label: Text('Preco')),
                                                DataColumn(label: Text('Qtde')),
                                                DataColumn(label: Text('Total'))
                                              ],
                                              source: _DataSource(
                                                  context, snapshot.data),
                                            ),
                                          ),
                                        ]);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }))
                      ])),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                sliver: SliverGrid.count(
                  childAspectRatio: 8,
                  crossAxisCount: 1,
                  children: <Widget>[
                    ElevatedButton(
                        child: Text("Finalizar"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            reportView(
                              context,
                            );
                          }
                        }),
                  ],
                ),
              ),
            ])));
  }

  Future<void> setOrcamento() async {
    idOrcamento = await controller.getOrcamentoPrefs();
  }

  @override
  void initState() {
    setOrcamento();
    super.initState();
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._rows);
  final BuildContext context;
  final List<ServicoOrcamentoModel> _rows;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row.descServico)),
        DataCell(Text(row.preco.toString())),
        DataCell(Text(row.qtde.toString())),
        DataCell(Text((row.preco * row.qtde).toString())),
      ],
      //onSelectChanged: (_) {}
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0; //selectedCount;
}
