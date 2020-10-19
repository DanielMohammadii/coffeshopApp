import 'package:coffee_app/constants/Loading.dart';
import 'package:coffee_app/models.dart/models.dart';
import 'package:coffee_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/constants/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  String _currentSugar;
  String _currentName;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return StreamBuilder<UserData>(
        stream: DataBaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      "Please Choose Your Coffee Detail",
                      style: TextStyle(color: Colors.brown, fontSize: 17.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Your Name"),
                      validator: (val) =>
                          val.isEmpty ? "Please Write your Name" : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    //DropDown for Choosing Sugars
                    DropdownButtonFormField(
                      value: (_currentSugar ?? userData.sugars),
                      decoration: textInputDecoration.copyWith(
                          hintText: "Please Choose Your Sugar"),
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "DoubleShot : 2 \nOneShot :      1",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.brown[600],
                      ),
                    ),
                    //Slider to Choosing the kind of Coffee : one Shot or Double Shot
                    Slider(
                      min: 1,
                      max: 2,
                      divisions: 2,
                      activeColor: Colors.brown,
                      inactiveColor: Colors.brown,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      label: _currentStrength.toString(),
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.round();
                        });
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    //RaiseButton to update Information
                    RaisedButton.icon(
                      color: Colors.brown[500],
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugar);
                        print(_currentStrength);
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
