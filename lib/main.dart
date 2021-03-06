import 'package:flutter/material.dart';
import 'package:seemur/src/pages/splash_scree_one_loading_screen.dart';
import 'package:seemur/src/providers/preferencias_usuario.dart';


void main() async {  WidgetsFlutterBinding.ensureInitialized();
final pref = new PreferenciasUsuario();
await pref.initPrefs();
  runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenOneLoading (),

    );
  }
}
