import 'package:chartify/provider/auth_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthProvider _auth;
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
        child: ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider.instance, child: _loginPageUI(),),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(
        builder:(BuildContext _context){
          _auth = Provider.of<AuthProvider>(_context);
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    return Container(
      height: _deviceHeight * 0.16,
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
      style: TextStyle(color: Colors.black),
      validator: (input) {
        return (input!=null && input.isNotEmpty) ? null : "Please enter password";
      },
      onSaved: (_input) {
        setState(() {
          _userPassword = _input!;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
  Widget _loginButton(){
    return Container(
      height: _deviceHeight*0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {
          if(_formKey.currentState!.validate()){
            _auth.loginUserWithEmailAndPassword(_userEmail, _userPassword);
          }
        },
        color: Colors.blue,
        child: Text(
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
    return GestureDetector(
      onTap: (){
        print('Okay');
        },
      child: Container(
        height: _deviceHeight*0.06,
        width: _deviceWidth,
        child: Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        )
      ),
    );
  }
}
