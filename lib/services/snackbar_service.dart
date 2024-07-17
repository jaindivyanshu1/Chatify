import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackbarService{
  late BuildContext _buildContext;
  static SnackbarService instance = SnackbarService();
  SnackbarService(){}
  set buildContext(BuildContext context){
    _buildContext = context;
  }
  // void showSnackBarError(String message){
  //   ScaffoldMessenger.of(_buildContext).showSnackBar(
  //       SnackBar(
  //       duration: Duration(seconds: 2),
  //       content: Text(
  //         message,
  //         style: TextStyle(color: Colors.white, fontSize: 15),
  //       ),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }

  void showSnackBarMethod(String message, {bool isError = false}){
    ScaffoldMessenger.of(_buildContext).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
              color: isError ? Colors.white : Colors.black,
              fontSize: 15,
          ),
        ),
        backgroundColor: isError ? Colors.red : Colors.greenAccent,
      ),
    );
  }


}