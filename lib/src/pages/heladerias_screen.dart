import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/client_body_screen.dart';
import 'package:seemur/src/widgets/bottom_navigator_bar_widget.dart';

class HeladeriaPage extends StatefulWidget {
  _HeladeriaPageState createState() => _HeladeriaPageState();
}

class _HeladeriaPageState extends State<HeladeriaPage> {
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
              'Heladerías',
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
      body: ListHeladerias(),
    );
  }
}

class ListHeladerias extends StatefulWidget {
  // ListBaresPage({Key key}) : super(key: key);

  _ListHeladeriasState createState() => _ListHeladeriasState();
}

class _ListHeladeriasState extends State<ListHeladerias> {
  Future getClient() async {
    print('hola');
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('client')
        .where('tasktags', arrayContains: 'Heladerías')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: Container(
            child: FutureBuilder(
              future: getClient(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text('Cargando Datos...'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      final datasnp = snapshot.data[index].data;
                      return Container(
                          child: Card(
                            color: Color.fromRGBO(246, 247, 250, 5),
                            elevation: 1,
                            child: InkWell(
                              onTap: () {
                                //print('${snapshot.data[index].data['taskname']}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientBody(
                                        datos: datasnp,
                                      )),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 30.0, height: 47.0),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                      width: 47,
                                      height: 47,
                                      fit: BoxFit.fill,
                                      placeholder:
                                      ('assets/images/Contenedordeimagenes.jpg'),
                                      image: (snapshot.data[index].data['logos']),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 21.0,
                                    height: 47.0,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    height: 72.0,
                                    child: ListTile(
                                      title: Container(
                                        child: Text(
                                          snapshot.data[index].data['taskname'],
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
                              ),
                            ),
                          ));
                    },
                  );
                }
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: NavigatorBar(navCallback: (i) => print("Navigating to $i")),
          ),
        ),
      ],
    );
  }
}