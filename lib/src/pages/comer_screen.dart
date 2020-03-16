

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/bares_screen.dart';
import 'package:seemur/src/pages/client_body_screen.dart';
import 'package:seemur/src/pages/gastro_pubs_screen.dart';
import 'package:seemur/src/pages/hoteles_screen.dart';
import 'package:seemur/src/pages/restaurantes_screen.dart';
import 'package:seemur/src/providers/preferencias_usuario.dart';
import 'package:seemur/src/widgets/bottom_navigator_bar_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ComerPage extends StatefulWidget {
  _ComerPageState createState() => _ComerPageState();
}

class _ComerPageState extends State<ComerPage> {
  final prefsus = new PreferenciasUsuario();
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(107.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Comer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: new IconButton(
              icon: new Icon(
                CupertinoIcons.back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 70,
        child: NavigatorBar(navCallback: (i) => print("Navigating to $i")),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.only(top: 48.0, left: 0, right: 60.0),
                          child: Text('Sugerencias para ti',
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.1,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26)),
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                height: 130,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Image.asset(
                                                        'assets/images/icons/restaurantsIcon@3x.png',
                                                        width: 38,
                                                        height: 38,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    RestaurantesPage()));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Restaurantes',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/icons/gastroPubIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                      context) =>
                                                                      GastroPubsPage()));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('GastroPubs',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/icons/barIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                      context) =>
                                                                      BaresPage()));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Bares',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/icons/hotelIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                      context) =>
                                                                      HotelesPage()));
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Hoteles',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                0.2000000029802322,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50.0,
                  color: Colors.white,
                  child: Text('Lugares',
                      style: TextStyle(
                        fontFamily: 'HankenGrotesk',
                        color: Color(0xff000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.5,
                      )),
                  padding: EdgeInsets.only(top: 16.0, left: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('client')
                          .where("tasktags", arrayContains: 'Comer')
                          .where(
                        'ciudad',
                        isEqualTo: prefsus.ciudad,
                      )
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Text("loading....");
                        } else {
                          return ListView.separated(
                              controller: _controller,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  Divider(
                                    color: Colors.grey,
                                  ),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, index) {
                                return ListTile(
                                  enabled: true,
                                  onTap: () {
                                    final datasnp =
                                        snapshot.data.documents[index].data;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ClientBody(
                                                datos: datasnp,
                                              )),
                                    );
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                      width: 46,
                                      height: 46,
                                      fit: BoxFit.cover,
                                      placeholder:
                                      ('assets/images/Contenedordeimagenes.jpg'),
                                      image: snapshot.data.documents[index]
                                      ['logos'],
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      child: Text(
                                        snapshot.data.documents[index]
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
                                  ),
                                  subtitle: Text(
                                    snapshot.data.documents[0]['taskfoods'][0]
                                        .toString()
                                        .replaceAll(
                                      new RegExp(r'[^\w\s\á-ú]+'),
                                      '',
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'HankenGrotesk',
                                      color: Color(0xff3D3D3D),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 34.0,
                                    height: 13.18,
                                    child: StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('calificar')
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("loading....");
                                          } else {
                                            return Row(
                                              children: <Widget>[
                                                Container(

                                                  child: SmoothStarRating(
                                                    borderColor:
                                                    Color(0xff16202C),
                                                    color: Color(0xfff5af00),
                                                    allowHalfRating: true,
                                                    rating: double.parse(
                                                        snapshot.data.documents[
                                                        index]['rating']),
                                                    size: 10.0,
                                                    starCount: 1,
                                                    spacing: 1.0,
                                                  ),
                                                ),
                                                Text(snapshot
                                                    .data
                                                    .documents[index]
                                                ['rating']
                                                    .toString() ??
                                                    '', style: TextStyle(
                                                    fontSize: 10),)
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}