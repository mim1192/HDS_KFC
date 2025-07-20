import 'package:flutter/material.dart';

//import 'package:in_app_update/in_app_update.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'dashboard_screen.dart'; // Replace with your actual dashboard screen
//import 'login_screen.dart'; // Replace with your actual login screen

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashFlow();
  }

  Future<void> _startSplashFlow() async {
    // Wait for GIF to show
    await Future.delayed(Duration(seconds: 3));

    // Check login status
    /*final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
*/
    String name = "Ali";
    if (name != "") {
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );*/
    } else {
      /*   Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('images/test.gif', fit: BoxFit.cover),
      ),
    );
  }
}
