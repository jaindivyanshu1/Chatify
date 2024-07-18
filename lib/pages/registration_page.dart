import 'dart:io';

import 'package:chartify/services/cloud_storage_service.dart';
import 'package:chartify/services/database_service.dart';
import 'package:chartify/services/media_service.dart';
import 'package:chartify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chartify/providers/auth_providers.dart';

import '../services/snackbar_service.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  late double _deviceHeight;
  late double _deviceWidth;
  late GlobalKey<FormState> _globalKey;
  late AuthProviders _authProviders;
  late String _name;
  late String _email;
  late String _password;
  File? _image;
  _RegistrationPageState(){
    _globalKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProviders>.value(value: AuthProviders.instance, child: signpPageUI()),
      ),
    );
  }
  Widget signpPageUI(){
    return Builder(
      builder: (BuildContext context) {
        _authProviders = Provider.of<AuthProviders>(context);
        return Container(
          height: _deviceHeight * 0.80,
          // color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth*0.10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingWidget(),
              _inputForm(),
              _registerButton(),
              _backToLoginPageButton(),
            ],
          ),
        );
      }
    );
  }
  Widget _headingWidget() {
    return SizedBox(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Let's get going!",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Please enter your detail",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _inputForm(){
    return SingleChildScrollView(
      // height: _deviceHeight * 0.40,
      child: Form(
        key: _globalKey,
        onChanged: (){
          _globalKey.currentState?.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageSelector(),
            SizedBox(height: 8,),
            _nameTextField(),
            SizedBox(height: 16,),
            _emailTextField(),
            SizedBox(height: 16,),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }
  Widget _imageSelector(){
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          File? imageFile = await MediaService.instance.getImageFromLibrary();
          setState(() {
            _image = imageFile!;
          });
        },
        child: Container(
          height: _deviceHeight*0.15,
          width: _deviceHeight * 0.15,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            // border: Border.all(color: Colors.blue),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null ? FileImage(_image!) : const NetworkImage("https://static.vecteezy.com/system/resources/previews/025/463/773/non_2x/hacker-logo-design-a-mysterious-and-dangerous-hacker-illustration-vector.jpg")as ImageProvider,
            )
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.black),
      validator: (input) {
        return (input!=null && input.isNotEmpty) ? null : "Please enter the valid name";
      },
      onSaved: (input) {
        setState(() {
          _name=input!;
        });
      },
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Name',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.black),
      validator: (input) {
        return (input!=null && input.isNotEmpty && input.contains('@')) ? null : "Please enter the valid email";
      },
      onSaved: (input) {
        setState(() {
          _email=input!;
        });
      },
      cursorColor: Colors.black,
      decoration: const InputDecoration(
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
          _password = input!;
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

  Widget _registerButton(){
    return _authProviders.status == AuthStatus.Authenticating
        ? Center(child: SizedBox(width: 100, child: const LinearProgressIndicator()))
        : Container(
      height: _deviceHeight*0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () async {
        //   if(_globalKey.currentState!.validate() && _image!=null){
        //     _authProviders.registerUserWithAndPassword(_email, _password, (String uid) async {
        //       var result = await CloudStorageService.instance.uploadUserImage(uid, _image);
        //       var imageURL = await result?.ref.getDownloadURL();
        //       await DatabaseService.instance.createUserInDb(uid, _name, _email, imageURL!);
        //     });
        //   }
        // },
          if (_globalKey.currentState!.validate() && _image != null) {
            _authProviders.registerUserWithAndPassword(_email, _password,
                    (String uid) async {
                  String? imageURL = await CloudStorageService.instance
                      .uploadUserImage(uid, _image!);
                  if (imageURL != null) {
                    await DatabaseService.instance
                        .createUserInDb(uid, _name, _email, imageURL);
                  } else {
                    SnackbarService.instance.showSnackBarMethod(
                        'Error uploading image',
                        isError: true);
                  }
                });
          }
        },
        color: Colors.blue,
        child: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
  Widget _backToLoginPageButton(){
    return GestureDetector(
      onTap: (){
        NavigationService.instance.goBack();
      },
      child: SizedBox(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: const Icon(Icons.arrow_back, size: 40,),
      ),
    );
  }
}
