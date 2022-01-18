// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on ChatStoreBase, Store {
  final _$observableStreamAtom = Atom(name: 'ChatStoreBase.observableStream');

  @override
  ObservableStream<List<ComentarioEntity>> get observableStream {
    _$observableStreamAtom.reportRead();
    return super.observableStream;
  }

  @override
  set observableStream(ObservableStream<List<ComentarioEntity>> value) {
    _$observableStreamAtom.reportWrite(value, super.observableStream, () {
      super.observableStream = value;
    });
  }

  final _$googleSignInAtom = Atom(name: 'ChatStoreBase.googleSignIn');

  @override
  GoogleSignIn get googleSignIn {
    _$googleSignInAtom.reportRead();
    return super.googleSignIn;
  }

  @override
  set googleSignIn(GoogleSignIn value) {
    _$googleSignInAtom.reportWrite(value, super.googleSignIn, () {
      super.googleSignIn = value;
    });
  }

  final _$currentUserAtom = Atom(name: 'ChatStoreBase.currentUser');

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

  final _$mensagemAtom = Atom(name: 'ChatStoreBase.mensagem');

  @override
  TextEditingController get mensagem {
    _$mensagemAtom.reportRead();
    return super.mensagem;
  }

  @override
  set mensagem(TextEditingController value) {
    _$mensagemAtom.reportWrite(value, super.mensagem, () {
      super.mensagem = value;
    });
  }

  final _$validacaoAtom = Atom(name: 'ChatStoreBase.validacao');

  @override
  GlobalKey<FormState> get validacao {
    _$validacaoAtom.reportRead();
    return super.validacao;
  }

  @override
  set validacao(GlobalKey<FormState> value) {
    _$validacaoAtom.reportWrite(value, super.validacao, () {
      super.validacao = value;
    });
  }

  final _$loginGoogleAsyncAction = AsyncAction('ChatStoreBase.loginGoogle');

  @override
  Future<User> loginGoogle(BuildContext context) {
    return _$loginGoogleAsyncAction.run(() => super.loginGoogle(context));
  }

  final _$ChatStoreBaseActionController =
      ActionController(name: 'ChatStoreBase');

  @override
  void setUser(User user) {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getComentarios() {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.getComentarios');
    try {
      return super.getComentarios();
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
observableStream: ${observableStream},
googleSignIn: ${googleSignIn},
currentUser: ${currentUser},
mensagem: ${mensagem},
validacao: ${validacao}
    ''';
  }
}