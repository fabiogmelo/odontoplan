import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @observable
  User currentUser;

  @action
  void getCurrentUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    this.currentUser = _auth.currentUser;
  }
}
