
import 'package:chartify/services/navigation_service.dart';
import 'package:chartify/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _needToShowLodder = false;
  late AuthProviders _auth;
  late double _deviceHeight;
  late double _deviceWidth;
  late String _userEmail;
  late String _userPassword;
  late final GlobalKey<FormState> _formKey;
  _LoginPageState() {
    _formKey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProviders>.value(value: AuthProviders.instance, child: _loginPageUI(),),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(
        builder:(BuildContext _context){
          SnackbarService.instance.buildContext = _context;
          _auth = Provider.of<AuthProviders>(_context);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth*0.10),
            height: _deviceHeight * 0.6,
            // color: Colors.red,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _headingWidget(),
                _inputTextForm(),
                _loginButton(),
                _registerButton(),
              ],
            ),
          );
        }
    );
  }

  Widget _headingWidget() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome Back!",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Please login to your account",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _inputTextForm() {
    return SingleChildScrollView(
      // height: _deviceHeight * 0.16,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState?.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _emailTextField(),
            SizedBox(height: 16,),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.black),
      validator: (_input) {
        return (_input!=null && _input.length!=0 && _input.contains('@')) ? null : "Please enter the valid email";
      },
      onSaved: (_input) {
        setState(() {
          _userEmail = _input!;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Email Address',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: const TextStyle(color: Colors.black),
      validator: (input) {
        return (input!=null && input.isNotEmpty) ? null : "Please enter password";
      },
      onSaved: (input) {
        setState(() {
          _userPassword = input!;
        });
      },
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
  Widget _loginButton(){
    return _auth.status == AuthStatus.Authenticating ? Center(child: SizedBox(width: 100, child: const LinearProgressIndicator())) : Container(
      height: _deviceHeight*0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {
          if(_formKey.currentState!.validate()){
            _auth.loginUserWithEmailAndPassword(_userEmail, _userPassword);
            if(_auth.status == AuthStatus.Authenticating){
              _needToShowLodder = true;
            }

          }
        },
        color: Colors.blue,
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
  Widget _registerButton(){
    return _auth.status==AuthStatus.Authenticating ? const Center() : GestureDetector(
      onTap: (){
        NavigationService.instance.navigationTo("register");
        },
      child: SizedBox(
        height: _deviceHeight*0.06,
        width: _deviceWidth,
        child: const Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        )
      ),
    );
  }
}
