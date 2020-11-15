// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LoginController = BindInject(
  (i) => LoginController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$currentUserAtom = Atom(name: '_LoginControllerBase.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$mErroAtom = Atom(name: '_LoginControllerBase.mErro');

  @override
  String get mErro {
    _$mErroAtom.reportRead();
    return super.mErro;
  }

  @override
  set mErro(String value) {
    _$mErroAtom.reportWrite(value, super.mErro, () {
      super.mErro = value;
    });
  }

  final _$signInWithGoogleAsyncAction =
      AsyncAction('_LoginControllerBase.signInWithGoogle');

  @override
  Future<bool> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  final _$signInWithTwitterAsyncAction =
      AsyncAction('_LoginControllerBase.signInWithTwitter');

  @override
  Future<bool> signInWithTwitter() {
    return _$signInWithTwitterAsyncAction.run(() => super.signInWithTwitter());
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
mErro: ${mErro}
    ''';
  }
}
