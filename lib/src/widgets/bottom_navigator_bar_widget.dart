

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur/src/pages/checkroles_screen.dart';
import 'package:seemur/src/pages/descubrir_screen.dart';
import 'package:seemur/src/pages/home_screen.dart';
import 'package:seemur/src/pages/preferences_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';
import 'package:seemur/src/providers/user_model_provider.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar(
      {Key key, this.user, this.auth, this.initialIndex: 0, this.navCallback})
      : super(key: key);
  final usuario = Usuario;
  final FirebaseUser user;
  final BaseAuth auth;
  final int initialIndex;
  final ValueChanged<int> navCallback;

  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex;
    notifyCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Expanded(
              child: FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return HomePage(
                          auth: Auth(),
                        );
                      }));
                      setState(() {
                        int index = 0;
                        onButtonTap(index);
                      });
                    },
                    child: _buildButton(0, CupertinoIcons.home, 'Inicio')),
            ),
            

               Expanded(
                 child: FlatButton(
                    onPressed: () {
                      setState(() {
                        int index = 1;
                        onButtonTap(index);
                      });

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return Descubrir();
                      }));
                    },
                    child: _buildButton(1, FontAwesomeIcons.compass,'Descubrir')),
               ),

            Expanded(


              child: FlatButton(
                onPressed: () {
                  setState(() {
                    int index = 2;

                    onButtonTap(index);
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return CheckRoles(
                      auth: Auth(),
                    );

//                  return ClientAddPage ();
                  }));
                },
                child: _buildButton(
                    2, IconData(59558, fontFamily: 'MaterialIcons'), 'Perfil'),
              ),
            ),
            Expanded(
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      int index = 3;

                      onButtonTap(index);
                    });
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return PreferencesPage(
                        auth: Auth(),
                      );
                      //return ClientAddPage ();
                    }));
                  },
                  child: _buildButton(3, CupertinoIcons.gear, 'Ajustes'),
                ),
            ),


          ],
        ),

    );
  }

  Widget _buildButton(int index, IconData data, String titulo) {
    return
       new FlatButton(
         onPressed: () => onButtonTap(index),

         child:
      Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: <Widget>[
            new Center(
              child: new Icon(
                data,
                color: _selected == index
                    ? Color.fromRGBO(245, 175, 0, 1)
                    : Colors.black87,
              ),
            ),
            Text(titulo,
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff3d3d3d),
                  fontSize: 8,

                  fontStyle: FontStyle.normal,
                ))
          ],
          ),
        ),
      );
  }

  onButtonTap(int index) {
    setState(() {
      _selected = index;
    });
    notifyCallback();
  }

  notifyCallback() {
    widget.navCallback(_selected);
  }
}
