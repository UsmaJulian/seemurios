import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/client_body_screen.dart';
import 'package:seemur/src/providers/preferencias_usuario.dart';

class RestaurantesParaTi extends StatefulWidget {
  _RestaurantesParaTiState createState() => _RestaurantesParaTiState();
}

class _RestaurantesParaTiState extends State<RestaurantesParaTi> {
  Future getEvent() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('client').getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final prefsus = new PreferenciasUsuario();

    return StreamBuilder(
        stream: Firestore.instance
            .collection('client')
            .where(
          'tasktags',
          arrayContains: 'Restaurante para ti',
        )
            .where(
          'ciudad',
          isEqualTo: prefsus.ciudad,
        )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            const Text('loading');
          } else {
            return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      "Restaurantes para ti",
                      style: TextStyle(
                        fontFamily: 'HankenGrotesk',
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.1000000014901161,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 104,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, idx) {
                          final datasnp = snapshot.data.documents[idx].data;
                          return Card(
                            color: Color.fromRGBO(246, 247, 250, 5),
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                //print('${snapshot.data[index].data['taskname']}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClientBody(
                                            datos: datasnp,
                                          )),
                                );
                              },
                              child: Row(
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
                                        image: (snapshot.data.documents[idx]
                                        ['logos']),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                    height: 78.0,
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(14, 0, 111, 0),
                                      title: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Container(
                                            child: Text(
                                              snapshot.data.documents[idx]
                                              ['taskname'],
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
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2),
                                            child: Container(
                                              child: Text(
                                                  snapshot.data.documents[idx]
                                                  ['tipo de recomendado'],
                                                  style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    color: Color(0xff3d3d3d),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing:
                                                    0.2000000029802322,
                                                  )),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10.0,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, idx) {
                          return SizedBox(width: 15);
                        },
                        padding: EdgeInsets.fromLTRB(24.0, 0, 0, 0),
                        itemCount: snapshot.data.documents.length),
                  )
                ]);
          }
          return Container();
        });
  }
}
