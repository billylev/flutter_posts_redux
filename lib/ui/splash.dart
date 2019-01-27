import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: Center(
                  child: new FlutterLogo(
                    size: 200.0,
                  ),
                ))
      );
  }
}