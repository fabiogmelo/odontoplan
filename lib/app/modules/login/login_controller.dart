import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final String _url = 'https://odontoplan2020.herokuapp.com/v1/graphql';
  HasuraConnect _hasuraConnect;

  @observable
  User currentUser;

  @observable
  String mErro;

  @action
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
    } on PlatformException catch (e) {
      mErro = e.code + ":" + e.message.toString();
      return false;
    }
    return true;
  }

  @action
  Future<bool> signInWithTwitter() async {
    // Create a TwitterLogin instance
    try {
      final TwitterLogin twitterLogin = new TwitterLogin(
        consumerKey: 'Vf3dnrni8O282ZetJye3kS70w',
        consumerSecret: 'sjvcfyR7mSs1clxwxVlKgVDcHGSCTQThmCuxe0ylEKFwErguuK',
      );

      // Trigger the sign-in flow
      final TwitterLoginResult loginResult = await twitterLogin.authorize();

      if (loginResult.status.index == 0) {
        final TwitterSession twitterSession = loginResult.session;

        // Create a credential from the access token
        final AuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
                accessToken: twitterSession.token,
                secret: twitterSession.secret);

        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

        currentUser = FirebaseAuth.instance.currentUser;
      } else {
        mErro = loginResult.errorMessage;
        return false;
      }
    } on PlatformException catch (e) {
      mErro = e.code + ":" + e.message.toString();
      return false;
    }
    return true;
  }

  /*
  @action
  Future<bool> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on PlatformException catch (e) {
      mErro = e.code + ":" + e.message;
      return false;
    }
    return true;
  }
   */
  HasuraConnect conectaBase() {
    this._hasuraConnect = HasuraConnect(_url);
    return _hasuraConnect;
  }

  void desconectaBase() {
    if (_hasuraConnect.isConnected) _hasuraConnect.disconnect();
  }
}
