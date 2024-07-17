import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {

  late GlobalKey<NavigatorState> navigatorKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigationTo(String routeName){
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigationToRoute(MaterialPageRoute route){
    return navigatorKey.currentState!.push(route);
  }

  void goBack(){
    return navigatorKey.currentState!.pop();
  }
}
