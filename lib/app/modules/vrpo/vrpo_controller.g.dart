// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrpo_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $VrpoController = BindInject(
  (i) => VrpoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VrpoController on _VrpoControllerBase, Store {
  final _$selectedCatAtom = Atom(name: '_VrpoControllerBase.selectedCat');

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
      AsyncAction('_VrpoControllerBase.consultaCategorias');

  @override
  Future<List<CategoriaModel>> consultaCategorias() {
    return _$consultaCategoriasAsyncAction
        .run(() => super.consultaCategorias());
  }

  final _$consultaServicosPorCategoriaAsyncAction =
      AsyncAction('_VrpoControllerBase.consultaServicosPorCategoria');

  @override
  Future<List<ServicoModel>> consultaServicosPorCategoria(String idCategoria) {
    return _$consultaServicosPorCategoriaAsyncAction
        .run(() => super.consultaServicosPorCategoria(idCategoria));
  }

  final _$consultaServicosPorOrcamentoAsyncAction =
      AsyncAction('_VrpoControllerBase.consultaServicosPorOrcamento');

  @override
  Future<List<ServicoModel>> consultaServicosPorOrcamento(String idOrcamento) {
    return _$consultaServicosPorOrcamentoAsyncAction
        .run(() => super.consultaServicosPorOrcamento(idOrcamento));
  }

  @override
  String toString() {
    return '''
selectedCat: ${selectedCat}
    ''';
  }
}
