import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/ui/home/home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);


class _SplashScreenState extends State<SplashScreen> {

  
  Duration duration = Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {

    DatabaseHelper.createDB();

    Route route = MaterialPageRoute(
      builder: (context) => HomeScreen()
    );

    Timer(
      duration, 
      () {
        Navigator.pushReplacement(context, route);
      }
    );
    
    return Scaffold(
      body: Container(
         child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      'assets/images/expanse.png',
                      width: double.infinity,
                    ),
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please wait...'
                    ),
                  )
                ],
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'App Version 1.0.0'
                )
              ),
            ),
          ],
        ),
       ),
    );
  }
}