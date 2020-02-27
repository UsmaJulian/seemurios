

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/bares_discos_recomendados_screen.dart';
import 'package:seemur/src/pages/comer_screen.dart';
import 'package:seemur/src/pages/descansar_screen.dart';
import 'package:seemur/src/pages/festejar_screen.dart';
import 'package:seemur/src/pages/proximos_eventos_screen.dart';
import 'package:seemur/src/pages/restaurantes_recomendados_screen.dart';
import 'package:seemur/src/pages/tardear_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';
import 'package:seemur/src/providers/user_model_provider.dart';
import 'package:seemur/src/utilities/constants.dart';
import 'package:seemur/src/widgets/bottom_navigator_bar_widget.dart';
import 'package:seemur/src/widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth});

  final BaseAuth auth;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final databaseReference = Firestore.instance;
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  final formKey = GlobalKey<FormState>();
  String _itemCiudad;
  List<DropdownMenuItem<String>> _ciudadItems;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');

        _ciudadItems = getCiudadItems();
        _itemCiudad = _ciudadItems[0].value;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  getData() async {
    return await Firestore.instance.collection('ciudades').getDocuments();
  }

  //Dropdownlist from firestore
  List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      dataCiudades = data;
      dataCiudades.documents.forEach((obj) {
        print('${obj.documentID} ${obj['nombre']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['nombre'],
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xffffffff),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ));
      });
    }).catchError((error) => print('hay un error.....' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('Ciudad ',
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Color(0xffffffff),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )),
    ));

    return items;
  }

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 1180.0,
                          decoration:
                          new BoxDecoration(color: Color(0xff16202c)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 0, top: 16.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        "¿Cuál es tu plan?",
                                        style: TextStyle(
                                          fontFamily: 'HankenGrotesk',
                                          color: Color(0xffffffff),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.4000000059604645,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      FutureBuilder(
                                        initialData: [],
                                        future: usersRef.document(id).get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child:
                                              CircularProgressIndicator(),
                                            );
                                          }
                                          Usuario usuario =
                                          Usuario.fromDoc(snapshot.data);
                                          return CircleAvatar(
                                              radius: 40.0,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: usuario
                                                  .profileImageUrl.isEmpty
                                                  ? AssetImage(
                                                  'assets/images/Contenedordeimagenes.jpg')
                                                  : CachedNetworkImageProvider(
                                                  usuario.profileImageUrl));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 0.0, right: 201.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff16202c),
                                    ),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true),
                                      validator: (value) =>
                                      value == '0'
                                          ? 'Debe seleccionar una ciudad'
                                          : null,
                                      value: _itemCiudad,
                                      items: _ciudadItems,
                                      onChanged: (value) {
                                        setState(() {
                                          _itemCiudad = value;
                                        });
                                      },
                                      //seleccionarCiudadItem,
                                      onSaved: (value) => _itemCiudad = value,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    SearchBar(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 233,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          // height: 1872,
                          decoration: new BoxDecoration(
                            color: Color(0xfff6f7fa),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, top: 47.0, right: 250.0),
                                child: Text("Explorar",
                                    style: TextStyle(
                                      fontFamily: 'HankenGrotesk',
                                      color: Color(0xff000000),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.1000000014901161,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(26)),
                                      margin:
                                      EdgeInsets.symmetric(vertical: 30.0),
                                      height: 130,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 24.0,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 105,
                                                  height: 92,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      new BorderRadius
                                                          .circular(6),
                                                      color: Color(0xff16202c),
                                                    ),
                                                    child: Center(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          FlatButton(
                                                            child: Image.asset(
                                                              'assets/images/icons/eatOutIcon@3x.png',
                                                              width: 38,
                                                              height: 38,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (
                                                                          context) =>
                                                                          ComerPage()));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text('Comer',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'HankenGrotesk',
                                                      color: Color(0xff000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                Text('',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Color(0xff3d3d3d),
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontStyle:
                                                      FontStyle.normal,
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
                                                      new BorderRadius
                                                          .circular(6),
                                                      color: Color(0xff16202c),
                                                    ),
                                                    child: Center(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 92,
                                                            width: 105,
                                                            child: FlatButton(
                                                                child:
                                                                Image.asset(
                                                                  'assets/images/icons/partiyingIcon@3x.png',
                                                                  width: 38,
                                                                  height: 38,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .push(
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              FestejarPage()));
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text('Festejar',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'HankenGrotesk',
                                                      color: Color(0xff000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                Text('',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Color(0xff3d3d3d),
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontStyle:
                                                      FontStyle.normal,
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
                                                      new BorderRadius
                                                          .circular(6),
                                                      color: Color(0xff16202c),
                                                    ),
                                                    child: Center(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 92,
                                                            width: 105,
                                                            child: FlatButton(
                                                                child:
                                                                Image.asset(
                                                                  'assets/images/icons/afternoonIcon@3x.png',
                                                                  width: 38,
                                                                  height: 38,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .push(
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              TardearPage()));
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text('Tardear',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'HankenGrotesk',
                                                      color: Color(0xff000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                Text('',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Color(0xff3d3d3d),
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontStyle:
                                                      FontStyle.normal,
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
                                                      new BorderRadius
                                                          .circular(6),
                                                      color: Color(0xff16202c),
                                                    ),
                                                    child: Center(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 92,
                                                            width: 105,
                                                            child: FlatButton(
                                                                child:
                                                                Image.asset(
                                                                  'assets/images/icons/restingIcon@3x.png',
                                                                  width: 38,
                                                                  height: 38,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .push(
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              DescansarPage()));
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text('Descansar',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'HankenGrotesk',
                                                      color: Color(0xff000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                Text('',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Color(0xff3d3d3d),
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      letterSpacing:
                                                      0.2000000029802322,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ProximosEventosPage(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 47.0, right: 0),
                                child:
                                RestaurantesParaTi(),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 47.0,
                                      right: 0.0,
                                      bottom: 50.0),
                                  child:
                                  BaresyDiscosParaTi()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), //Poner searchbar
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 70,
                child:
                NavigatorBar(navCallback: (i) => print("Navigating to $i")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
