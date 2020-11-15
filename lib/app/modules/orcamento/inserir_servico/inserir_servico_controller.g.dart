// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inserir_servico_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $InserirServicoController = BindInject(
  (i) => InserirServicoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InserirServicoController on _InserirServicoControllerBase, Store {
  final _$selectedCatAtom =
      Atom(name: '_InserirServicoControllerBase.selectedCat');

  @override
  String get selectedCat {
    _$selectedCatAtom.reportRead();
    return super.selectedCat;
  }

  @override
  set selectedCat(String value) {
    _$selectedCatAtom.reportWrite(value, super.selectedCat, () {
      super.selectedCat = value;
    });
  }

  final _$consultaCategoriasAsyncAction =
      AsyncAction('_InserirServicoControllerBase.consultaCategorias');

  @override
  Future<List<CategoriaModel>> consultaCategorias() {
    return _$consultaCategoriasAsyncAction
        .run(() => super.consultaCategorias());
  }

  final _$consultaServicosPorCategoriaAsyncAction =
      AsyncAction('_InserirServicoControllerBase.consultaServicosPorCategoria');

  @override
  Future<List<ServicoModel>> consultaServicosPorCategoria(String idCategoria) {
    return _$consultaServicosPorCategoriaAsyncAction
        .run(() => super.consultaServicosPorCategoria(idCategoria));
  }

  final _$consultaServicosPorOrcamentoAsyncAction =
      AsyncAction('_InserirServicoControllerBase.consultaServicosPorOrcamento');

  @override
  Future<List<ServicoOrcamentoModel>> consultaServicosPorOrcamento(
      int idOrcamento) {
    return _$consultaServicosPorOrcamentoAsyncAction
        .run(() => super.consultaServicosPorOrcamento(idOrcamento));
  }

  final _$insereServicoOrcamentoAsyncAction =
      AsyncAction('_InserirServicoControllerBase.insereServicoOrcamento');

  @override
  Future<void> insereServicoOrcamento(
      int idOrcamento, int idServico, int qtde) {
    return _$insereServicoOrcamentoAsyncAction
        .run(() => super.insereServicoOrcamento(idOrcamento, idServico, qtde));
  }

  @override
  String toString() {
    return '''
selectedCat: ${selectedCat}
    ''';
  }
}
