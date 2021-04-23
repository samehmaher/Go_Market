import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_market/component/background_Image.dart';
import 'package:go_market/home_screen.dart';
import 'package:go_market/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.mail});
  final String mail;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (widget.mail==null)?LoginScreen():HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/splash_bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(child: SizedBox()),
              Flexible(
                child: Center(
                  child: Text(
                    'Go Market',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SpinKitPumpingHeart(
                color: Colors.white,
                size: 50.0,
              ),
              Expanded(child: SizedBox())
            ],
          ),
        )
      ],
    );
  }
}
