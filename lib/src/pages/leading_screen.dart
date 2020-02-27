


import 'package:flutter/material.dart';
import 'package:seemur/src/pages/home_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';

class LeadingPage extends StatefulWidget {
  @override
  _LeadingPageState createState() => _LeadingPageState();
}

class _LeadingPageState extends State<LeadingPage> {
  String userID;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print(' $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        HomePage(
          auth: Auth(),
        ),

      ]),
    );
  }
}