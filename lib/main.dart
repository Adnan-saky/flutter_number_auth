import 'package:flutter/material.dart';
import 'package:g_in/home.dart';
import 'package:g_in/login.dart';
//import 'package:g_in/loginfb.dart';
import 'package:g_in/loginph.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'loginfb',
      routes: {
        'start': (context) => MyApp(),
        'login': (context) => LoginPage(),
        'home': (context) => HomeScreen(),
        'loginphone': (context) => LoginPhone(),
        //'loginfb': (context) => LoginFb(),
      },
    );
  }
}
