import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/providers/auth_provider.dart';
import 'package:seemur/src/widgets/bottom_navigator_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpresasPage extends StatefulWidget {
  EmpresasPage({this.auth});
  final BaseAuth auth;

  _EmpresasPageState createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            CupertinoIcons.back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(22, 32, 44, 1),
        title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Text('Empresas',
                  style: TextStyle(
                    fontFamily: 'HankenGrotesk',
                    color: Color(0xffffffff),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.5,
                  )),
            )),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                child: Container(
                  height: 66.0,
                  width: MediaQuery.of(context).size.width,
                  child: new FlatButton(
                      onPressed: () {
                        _launchURL();
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 92.0),
                            child: new Text('Inscribir mi empresa en Seemur',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: NavigatorBar(
                  navCallback: (i) => print("Navigating to $i")),
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://www.seemur.com/establecimientos';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede lanzar la url $url';
  }
}
