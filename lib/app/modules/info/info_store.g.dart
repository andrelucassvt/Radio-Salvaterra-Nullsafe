// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InfoStore on _InfoStoreBase, Store {
  final _$valueAtom = Atom(name: '_InfoStoreBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_InfoStoreBaseActionController =
      ActionController(name: '_InfoStoreBase');

  @override
  void increment() {
    final _$actionInfo = _$_InfoStoreBaseActionController.startAction(
        name: '_InfoStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$_InfoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
