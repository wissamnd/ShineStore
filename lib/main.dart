import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/splashScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shine Stores',
      theme: ThemeData(
        primarySwatch: Colors.red,
        
      ),
      home: SplashScreen(),
    );
  }
}
