import 'package:odontoplan/app/models/servico_model.dart';
import 'package:odontoplan/app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'vrpo_controller.dart';

class VrpoPage extends StatefulWidget {
  final String title;
  const VrpoPage({Key key, this.title = "Tabela VRPO"}) : super(key: key);

  @override
  _VrpoPageState createState() => _VrpoPageState();
}

class _VrpoPageState extends ModularState<VrpoPage, VrpoController> {
  //use 'controller' variable to access controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
              sliver: SliverGrid.count(
                childAspectRatio: 4,
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
                                  validator: () {},
                                  update: _update);
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
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
              sliver: SliverGrid.count(
                  childAspectRatio: 0.1,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Container(
                        child: FutureBuilder(
                            future: controller.consultaServicosPorCategoria(
                                controller.selectedCat),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                  padding: const EdgeInsets.all(1),
                                  children: [
                                    PaginatedDataTable(
                                      header: Text('Valores de Referência'),
                                      initialFirstRowIndex: 0,
                                      rowsPerPage: 7,
                                      columns: [
                                        DataColumn(label: Text('Serviço')),
                                        DataColumn(label: Text('Valor')),
                                      ],
                                      source:
                                          _DataSource(context, snapshot.data),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })),
                  ]),
            )
          ],
        ));
  }

  void _update(String b) {
    setState(() {
      controller.selectedCat = b;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.selectedCat = '0';
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._rows);
  final BuildContext context;
  final List<ServicoModel> _rows;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    //if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row.descricao)),
        DataCell(Text(row.preco)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
