import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }

  User get getUser => _user!;

}
  //this will notify UserProvider that the global variable has changed, so you need to update the values.
    //to add some listners we will go to our main.dart file and wrap our MaterialApp with MultiProvider
    //it will take a list of providers
    //we are using this approach because if we wrap our total app with MultiProvider, it is a one time shot to use listners.
    //if we dont use this approach we will have to use consumers and providers again and again.
    //using consumers and providers is another way of adding and using listners in our application.
    //there are also multiple ways to add listners.
