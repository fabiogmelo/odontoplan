import 'package:odontoplan/app/widgets/custom_dropdown.dart';
import 'package:odontoplan/app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'inserir_orcamento_controller.dart';
import 'package:intl/intl.dart';

class InserirOrcamentoPage extends StatefulWidget {
  final String title;
  const InserirOrcamentoPage({Key key, this.title = "Inserir Orcamento"})
      : super(key: key);

  @override
  _InserirOrcamentoPageState createState() => _InserirOrcamentoPageState();
}

class _InserirOrcamentoPageState
    extends ModularState<InserirOrcamentoPage, InserirOrcamentoController> {
  //use 'controller' variable to access controller
  final _formKey = GlobalKey<FormState>();
  List<Planos> items;
  String plano;
  DateTime selectedDate = DateTime.now();
  String cliente;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          shrinkWrap: true,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(4, 5, 4, 1),
                sliver: SliverGrid.count(
                    childAspectRatio: 5,
                    crossAxisCount: 1,
                    children: <Widget>[
                      CustomTextField(
                        messageValidator: 'Insira o nome do Cliente',
                        labelText: 'Nome do Cliente',
                        onChanged: (String value) {
                          cliente = value;
                        },
                      )
                    ])),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(4, 5, 4, 1),
                sliver: SliverGrid.count(
                    childAspectRatio: 2.5,
                    crossAxisCount: 2,
                    children: <Widget>[
                      CustomTextField(
                        prefixIcon: Icon(Icons.date_range),
                        readOnly: false,
                        messageValidator: 'Data invalida',
                        labelText: 'Data',
                        onTap: () {
                          _selectDate(context);
                        },
                        initialValue:
                            DateFormat('dd-MM-yyyy').format(selectedDate),
                      ),
                      CustomDropdown(
                        menuOptions: items,
                        update: (String value) {
                          setState(() {
                            plano = items
                                .where((plano) => plano.id.toString() == value)
                                .first
                                .descricao;
                          });
                        },
                        labelText: 'Plano de Saude',
                        validator: (value) =>
                            value == null ? 'Selecione um plano' : null,
                      ),
                    ])),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 1),
                sliver: SliverGrid.count(
                    childAspectRatio: 5,
                    crossAxisCount: 1,
                    children: <Widget>[
                      ButtonBar(
                        mainAxisSize: MainAxisSize
                            .min, // this will take space as minimum as posible(to center)
                        children: <Widget>[
                          new ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                int chave = await controller.insereOrcamento(
                                    cliente,
                                    controller.currentUser.uid,
                                    selectedDate.toString(),
                                    plano);

                                controller.setOrcamentoPrefs(chave);
                                Navigator.pushNamed(context, "/InserirServ");
                              }
                            },
                            child: Text('Avançar'),
                          ),
                        ],
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    items = new List<Planos>();
    items.add(Planos(1, 'Particular'));
    items.add(Planos(2, 'Camed'));
    items.add(Planos(3, 'Unimed'));
  }
}

class Planos {
  int id;
  String descricao;
  Planos(this.id, this.descricao);
}
