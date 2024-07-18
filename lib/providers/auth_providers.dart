import 'package:chartify/services/navigation_service.dart';
import 'package:chartify/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProviders extends ChangeNotifier {
  late User user ;
  late AuthStatus status = AuthStatus.NotAuthenticated;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static AuthProviders instance = AuthProviders();
  AuthProviders() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  // chatgpt

  void _onAuthStateChanged(User? user) {
    if (user == null) {
      status = AuthStatus.NotAuthenticated;
    } else {
      this.user = user;
      status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  //chatgpt


  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user!;
      status = AuthStatus.Authenticated;
      SnackbarService.instance.showSnackBarMethod('LoggedIn');
      print("LoggedIn");
      NavigationService.instance.navigationToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
      SnackbarService.instance.showSnackBarMethod(
        'Error logging in: ${e.toString()}',
        isError: true,
      );
      print('Error done');
    }
    notifyListeners();
  }

  Future<void> registerUserWithAndPassword(String email, String password, Future<void> Function(String uid) onSuccess) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try{
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("****************///////******************");
      user = res.user!;
      print("--------------------///////******************");
      status = AuthStatus.Authenticated;
      // String uidF = user.uid;
      await onSuccess(user.uid);
      SnackbarService.instance.showSnackBarMethod('Login With Same Credentials');
      //Update last seen time
      NavigationService.instance.goBack();
      //Navigate to home page
      NavigationService.instance.navigationToReplacement("home");
    }catch(e){
      status = AuthStatus.Error;
      SnackbarService.instance.showSnackBarMethod('Error Registering User:', isError: true);
      print('$e');
    }
    notifyListeners();
  }
}
