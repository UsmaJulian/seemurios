import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:seemur/src/pages/login_screen.dart';
import 'package:seemur/src/providers/auth_provider.dart';
import 'package:seemur/src/widgets/bottom_navigator_bar_widget.dart';

class ClientAddPage extends StatefulWidget {
  final String id;
  const ClientAddPage({this.id, this.user, this.auth});
  final FirebaseUser user;
  final BaseAuth auth;
  @override
  _ClientAddPageState createState() => _ClientAddPageState();
}

class _ClientAddPageState extends State<ClientAddPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail

  //we declare the variables
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

  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;
  String client;
  Auth auth = Auth();

  TextEditingController taskdescriptionInputController;
  TextEditingController tasknameInputController;
  TextEditingController taskclientimageInputController;
  TextEditingController tasklocationInputController;
  TextEditingController taskpriceInputController;
  TextEditingController taskphoneInputController;
  TextEditingController tasktimeInputController;
  TextEditingController taskhomeserviceInputController;
  TextEditingController taskfoodsInputController;
  TextEditingController taskpaymentInputController;
  TextEditingController taskservicesInputController;
  TextEditingController taskplansInputController;
  TextEditingController taskfeaturesInputController;
  TextEditingController taskenvironmentsInputController;
  TextEditingController tasktagsInputController;
  TextEditingController taskoutfitInputController;
  TextEditingController taskrecommendeddishesInputController;
  TextEditingController taskfeaturedimagesInputController;
  TextEditingController taskratingInputController;
  TextEditingController taskratingcountInputController;
  TextEditingController tasktotalratingInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String uid;
  String taskdescription;
  String tasklocation;
  String taskname;
  String taskphone;
  String taskprice;
  String tasktime;
  String taskclientimage;
  String taskhomeservice;
  List taskfoods;
  String taskpayment;
  List taskservices;
  List taskplans;
  List taskfeatures;
  List taskenvironments;
  List tasktags;
  String taskoutfit;
  List taskrecommendeddishes;
  List taskfeaturedimages;
  String rating;
  String ratingcount;
  String totalrating;
  String logos;

  //we create a method to obtain the image from the camera or the gallery

  Future captureImage(SelectSource opcion) async {
    File taskclientimage;

    opcion == SelectSource.camara
        ? taskclientimage =
    await ImagePicker.pickImage(source: ImageSource.camera)
        : taskclientimage =
    await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = taskclientimage;
    });
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione de donde desea capturar la imagen'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.camara;
            captureImage(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.galeria;
            captureImage(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(context: context, child: alerta);
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  //crated a method validate
  bool _validarlo() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //create a method send and create recipe in Cloud Firestore
  void _enviar() {
    if (_validarlo()) {
      setState(() {
        _isInAsyncCall = true;
      });
      auth.currentUser().then((onValue) {
        setState(() {
          uid = onValue;
        });
        if (_foto != null) {
          final StorageReference fireStoreRef = FirebaseStorage.instance
              .ref()
              .child('client')
              .child('taskname')
              .child(uid)
              .child('uid')
              .child('tasklocation')
              .child('logos')
              .child('taskphone')
              .child('taskprice')
              .child('tasktime')
              .child('taskdescription')
              .child('taskhomeservice')
              .child('taskfoods')
              .child('taskpayment')
              .child('taskservices')
              .child('taskplans')
              .child('taskfeatures')
              .child('taskenvironments')
              .child('tasktags')
              .child('taskoutfit')
              .child('taskrecommededdishes')
              .child('taskfeaturedimages')
              .child('rating')
              .child('ratingcount')
              .child('totalrating')
              .child('$taskclientimage.jpg');
          final StorageUploadTask task = fireStoreRef.putFile(
              _foto, StorageMetadata(contentType: 'image/jpeg'));

          task.onComplete.then((onValue) {
            onValue.ref.getDownloadURL().then((onValue) {
              setState(() {
                urlFoto = onValue.toString();
                Firestore.instance
                    .collection('client')
                    .add({
                  'taskname': taskname,
                  'uid': uid,
                  'taskclientimage': taskclientimage,
                  'taskclientimage': urlFoto,
                  'taskdescription': taskdescription,
                  'tasklocation': tasklocation,
                  'logos': logos,
                  'taskphone': taskphone,
                  'taskprice': taskprice,
                  'tasktime': tasktime,
                  'taskhomeservice': taskhomeservice,
                  'taskfoods': taskfoods,
                  'taskpayment': taskpayment,
                  'taskservices': taskservices,
                  'taskplans': taskplans,
                  'taskfeatures': taskfeatures,
                  'taskenvironments': taskenvironments,
                  'tasktags': tasktags,
                  'taskoutfit': taskoutfit,
                  'taskrecommendeddishes': taskrecommendeddishes,
                  'taskfeaturedimages': taskfeaturedimages,
                  'rating': rating,
                  'ratingcount': ratingcount,
                  'totalrating': totalrating,
                })
                    .then((value) => Navigator.of(context).pop())
                    .catchError((onError) =>
                    print('Error en registrar el usuario en la bd'));
                _isInAsyncCall = false;
              });
            });
          });
        } else {
          Firestore.instance
              .collection('client')
              .add({
            'taskname': taskname,
            'uid': uid,
            'taskclientimage': taskclientimage,
            'taskclientimage': urlFoto,
            'taskdescription': taskdescription,
            'tasklocation': tasklocation,
            'logos': logos,
            'taskphone': taskphone,
            'taskprice': taskprice,
            'tasktime': tasktime,
            'taskhomeservice': taskhomeservice,
            'taskfoods': taskfoods,
            'taskpayment': taskpayment,
            'taskservices': taskservices,
            'taskplans': taskplans,
            'taskfeatures': taskfeatures,
            'taskenvironments': taskenvironments,
            'tasktags': tasktags,
            'taskoutfit': taskoutfit,
            'taskrecommendeddishes': taskrecommendeddishes,
            'taskfeaturedimages': taskfeaturedimages,
            'rating': rating,
            'ratingcount': ratingcount,
            'totalrating': totalrating,
          })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                  (onError) => print('Error en registrar el usuario en la bd'));
          _isInAsyncCall = false;
        }
      }).catchError((onError) => _isInAsyncCall = false);

      //

    } else {
      print('objeto no validado');
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Text('Agregar cliente'),
        ),
        body: Stack(
          children: <Widget>[
            ModalProgressHUD(
              inAsyncCall: _isInAsyncCall,
              opacity: 0.5,
              dismissible: false,
              progressIndicator: CircularProgressIndicator(),
              color: Colors.blueGrey,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 10, right: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: getImage,
                            ),
                            margin: EdgeInsets.only(top: 20),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: 1.0, color: Colors.black),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: _foto == null
                                        ? AssetImage('assets/images/azucar.gif')
                                        : FileImage(_foto))),
                          )
                        ],
                      ),
                      Text('click para cambiar foto'),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nombre',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                          onSaved: (value) => taskname = value.trim(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 4, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Descripción',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some description';
                            }
                          },
                          onSaved: (value) => taskdescription = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ubicación',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some location';
                            }
                          },
                          onSaved: (value) => tasklocation = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Telefono',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some phone';
                            }
                          },
                          onSaved: (value) => taskphone = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Precio',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some price';
                            }
                          },
                          onSaved: (value) => taskprice = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Horario',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some time';
                            }
                          },
                          onSaved: (value) => tasktime = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Domicilio',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some value';
                            }
                          },
                          onSaved: (value) => taskhomeservice = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tipo de comida',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some food';
                            }
                          },
                          onSaved: (value) => taskfoods = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Forma de pago',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some type';
                            }
                          },
                          onSaved: (value) => taskpayment = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Servicios',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some services';
                            }
                          },
                          onSaved: (value) => taskservices = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Plan',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some plan';
                            }
                          },
                          onSaved: (value) => taskplans = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Características',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some features';
                            }
                          },
                          onSaved: (value) => taskfeatures = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ambiente',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some environment';
                            }
                          },
                          onSaved: (value) =>
                          taskenvironments = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Etiquetas',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some tags';
                            }
                          },
                          onSaved: (value) => tasktags = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tipo de vestuario',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some outfit';
                            }
                          },
                          onSaved: (value) => taskoutfit = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' Recomendados',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some dishes';
                            }
                          },
                          onSaved: (value) =>
                          taskrecommendeddishes = value.split(','),
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          maxLines: 1, //numero de lineas aceptadas
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Imagenes destacadas ',
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some images';
                            }
                          },
                          onSaved: (value) => taskfeaturedimages = [
                            'assets/images/seemurIsotipo.png',
                            'assets/images/seemurIsotipo.png',
                            'assets/images/seemurIsotipo.png'
                          ],
                          // onSaved: (value) => taskfoods = ['comida1','comida2'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 98.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: _enviar,
                              child: Text('Crear',
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xff16202c),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
        ));
  }
}
