import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:odontoplan/app/models/orcamento_model.dart';
import 'package:odontoplan/app/models/servico_orcamento_model.dart';
import 'package:odontoplan/app/modules/orcamento/relatorio/relatorio_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as material;

reportView(context,
    {OrcamentoModel orcamento, List<ServicoOrcamentoModel> servicos}) async {
  final Document pdf = Document();
  final String dir = (await getApplicationDocumentsDirectory()).path;

  ByteData clockData = (await rootBundle.load('assets/images/dente.png'));
  Uint8List clockBytes = clockData.buffer.asUint8List();

  final image = PdfImage.file(
    pdf.document,
    bytes: clockBytes,
  );

  pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('Orçamento',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
            Header(
                level: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('OdontoPlan', textScaleFactor: 5),
                      Image(
                        image,
                        width: 100,
                        height: 100,
                      ),
                    ])),
            Header(level: 1, text: 'Orçamento Odontológico'),
            Paragraph(text: 'Paciente: Laisa Mota'),
            Paragraph(text: 'Data:14-11-2020'),
            Paragraph(text: 'Plano: Camed'),
            Header(level: 1, text: 'Procedimentos'),
            Padding(padding: const EdgeInsets.all(10)),
            Table.fromTextArray(context: context, data: const <List<String>>[
              <String>['Serviço', 'Quantidade', 'Valor'],
              <String>['Slides (unidade)', '1', 'R\$ 21,89'],
              <String>[
                'Profilaxia: Polimento coronário (quatro hemiarcadas)',
                '1',
                'R\$ 100,83'
              ],
              <String>['Orientação de higiene bucal', '2', 'R\$ 145,48'],
              <String>['Total', '--------------------', 'R\$ 268,2'],
            ]),
          ]));

  final String path = '$dir/Orcamento.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => RelatorioPage(path: path),
    ),
  );
}
