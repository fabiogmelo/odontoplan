import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  final String header;
  final int rowsPerPage;
  final List<dynamic> data;
  CustomListView(this.header, this.rowsPerPage, this.data);

  @override
  _CustomListView createState() => _CustomListView();
}

class _CustomListView extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(1),
      children: [
        PaginatedDataTable(
          header: Text(widget.header),
          rowsPerPage: widget.rowsPerPage,
          columns: [
            DataColumn(label: Text('Serviço')),
            DataColumn(label: Text('Valor')),
          ],
          source: _DataSource(context, widget.data),
        ),
      ],
    );
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._rows);
  final BuildContext context;
  final List<dynamic> _rows;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
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
