import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_market/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref=await SharedPreferences.getInstance();
  String mail =pref.getString('email');
  runApp(Home(mail: mail,));
}
class Home extends StatelessWidget {
  Home({this.mail});
  final String mail;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Market',
      theme: ThemeData(
        textTheme:
        GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(mail: mail,),
    );
  }
}

