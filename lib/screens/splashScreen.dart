import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_shop/screens/homePage.dart';
import 'package:flutter_shop/logic/storeState.dart';
import 'package:flutter_shop/logic/userState.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void initState() {
    super.initState();
    StoreState.initialize().then((_){
      UserState.initialize().then((_){
          startTime();
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body:new Container(
        padding: EdgeInsets.all(50.0),
        child: new Center(
          child:Text("Shine Stores",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),)
        ),
      )
      
    );
  }
}