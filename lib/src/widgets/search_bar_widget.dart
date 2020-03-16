import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur/src/pages/search_result_screen.dart';
import 'package:seemur/src/services/search_service.dart';
import 'package:seemur/src/widgets/filtros_widget.dart';

class SearchBar extends StatefulWidget {
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController controller = new TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByString(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['taskname'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.87,
          height: MediaQuery
              .of(context)
              .size
              .width * 0.12,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(23),
              border: Border.all(
                color: Colors.transparent,
              )),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              top: 8.0,
            ),
            child: Center(
              child: new TextField(
                controller: controller,
                decoration: new InputDecoration(

                  border: InputBorder.none,
                  hintText: 'Buscar ',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                onChanged: (value) {
                  initiateSearch(value);
                },
                onEditingComplete: () {
                  controller.text = controller.text[0].toUpperCase() +
                      controller.text.substring(1);
                  print(controller.text);
                  var valor = controller.text;
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SearchResult(valor: valor)));
                },
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          bottom: 4,
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.055,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.25,
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(22), right: Radius.circular(22)),
              gradient: LinearGradient(
                colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: FlatButton(
              child: AutoSizeText('Filtros',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  )),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => FiltrosPage()));
              },
            ),
          ),
        ),
      ],
    );
  }
}
