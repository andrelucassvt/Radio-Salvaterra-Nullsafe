import 'package:mobx/mobx.dart';

part 'info_store.g.dart';

class InfoStore = _InfoStoreBase with _$InfoStore;
abstract class _InfoStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}