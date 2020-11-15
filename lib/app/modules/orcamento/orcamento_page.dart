import 'package:odontoplan/app/models/orcamento_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'orcamento_controller.dart';

class OrcamentoPage extends StatefulWidget {
  final String title;
  const OrcamentoPage({Key key, this.title = "Orcamento"}) : super(key: key);

  @override
  _OrcamentoPageState createState() => _OrcamentoPageState();
}

class _OrcamentoPageState
    extends ModularState<OrcamentoPage, OrcamentoController> {
  final _formKey = GlobalKey<FormState>();
  //use 'controller' variable to access controller
  String _date;

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
                  padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                  sliver: SliverGrid.count(
                      childAspectRatio: 0.8,
                      crossAxisCount: 1,
                      children: <Widget>[
                        Container(
                            child: FutureBuilder(
                                future: controller.consultaOrcamentos(_date),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView(
                                      padding: const EdgeInsets.all(16),
                                      children: [
                                        PaginatedDataTable(
                                          header:
                                              Text('Orçamentos Cadastrados'),
                                          rowsPerPage: 5,
                                          columns: [
                                            DataColumn(label: Text('Cliente')),
                                            DataColumn(label: Text('Data')),
                                            DataColumn(label: Text('Valor')),
                                          ],
                                          source: _DataSource(
                                              context, snapshot.data),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }))
                      ])),
              SliverPadding(
                  padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                  sliver: SliverGrid.count(
                      childAspectRatio: 8,
                      crossAxisCount: 1,
                      children: <Widget>[
                        Container(
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/InserirOrca");
                            },
                            child: Icon(Icons.add),
                          ),
                        )
                      ])),
              SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
                  sliver: SliverGrid.count(
                      childAspectRatio: 5,
                      crossAxisCount: 1,
                      children: <Widget>[Container()]))
            ])));
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._rows);
  final BuildContext context;
  final List<OrcamentoModel> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row.cliente)),
        DataCell(Text(row.data)),
        DataCell(Text(row.valortotal.toString())),
      ],
      //onSelectChanged: (_) {}
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
