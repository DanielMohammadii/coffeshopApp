import 'package:coffee_app/models.dart/models.dart';
import 'package:coffee_app/screens/authenticate/authenticate.dart';
import 'package:coffee_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
