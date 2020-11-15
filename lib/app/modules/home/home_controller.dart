import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  User currentUser;

  @action
  Future<void> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    this.currentUser = currentUser = _auth.currentUser;
  }
}
