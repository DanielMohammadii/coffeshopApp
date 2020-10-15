import 'package:coffee_app/screens/authenticate/Signin.dart';
import 'package:coffee_app/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignIn = true;
  void toggle() {
    setState(() {
      showsignIn = !showsignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignIn) {
      return SignIn(toggle: toggle);
    } else {
      return Register(toggle: toggle);
    }
  }
}
