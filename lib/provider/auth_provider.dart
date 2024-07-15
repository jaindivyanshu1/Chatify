import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus{
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier{
  late User user;
  late AuthStatus status;
  late FirebaseAuth _auth = FirebaseAuth.instance;
  static AuthProvider instance = AuthProvider();
  AuthProvider(){
    _auth = FirebaseAuth.instance;
  }
  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try{
      UserCredential _result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.Authenticated;
      print("LoggedIn");
    }catch(e){
      status = AuthStatus.Error;
      print('Error');
    }
    notifyListeners();
  }
}
