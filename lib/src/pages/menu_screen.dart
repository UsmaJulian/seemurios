import 'package:flutter/material.dart';
import 'package:seemur/src/pages/content_screen.dart';
import 'package:seemur/src/pages/leading_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';

const PrimaryColor = const Color(0xFF19212B);

class MenuPage extends StatefulWidget {
  MenuPage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;

  Content page = ContentPage();

  Widget contentPage = LeadingPage(); //Pagina principal recetas

  void _signOut() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: contentPage,
    );
  }
}
