import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/client_body_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';

class LugaresVistadosPage extends StatefulWidget {
  final BaseAuth auth;

  LugaresVistadosPage({this.auth});

  _LugaresVistadosPageState createState() => _LugaresVistadosPageState();
}

class _LugaresVistadosPageState extends State<LugaresVistadosPage> {
  String id;

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
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
              child: Text('Lugares visitados',
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
      body: FutureBuilder(
        future: Firestore.instance
            .collection('usuarios')
            .document(id)
            .collection('visitados')
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            Text('Loading');
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                          placeholder:
                          ('assets/images/Contenedordeimagenes.jpg'),
                          image: (snapshot.data.documents[index]['logos']
                              .toString()),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 72.0,
                      child: ListTile(
                        dense: true,
                        onTap: () {
                          var datasnp = snapshot.data.documents[index].data;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClientBody(datos: datasnp)),
                          );
                        },
                        title: Container(
                          child: Text(
                            snapshot.data.documents[index]['taskname'],
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
