import 'dart:io';

import 'package:chartify/services/media_service.dart';
import 'package:chartify/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/auth_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  late double _deviceHeight;
  late double _deviceWidth;
  late GlobalKey<FormState> _globalKey;
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
        child: signpPageUI(),
      ),
    );
  }
  Widget signpPageUI(){
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
            _image = imageFile;
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
              image: _image != null ? FileImage(_image!) : NetworkImage("https://static.vecteezy.com/system/resources/previews/025/463/773/non_2x/hacker-logo-design-a-mysterious-and-dangerous-hacker-illustration-vector.jpg"),
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
        setState(() {});
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
        setState(() {});
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
        setState(() {});
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
    return Container(
      height: _deviceHeight*0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {},
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
