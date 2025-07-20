import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hds_ptcl/screens/log_in/components/sign_in_form.dart';
import 'package:hds_ptcl/screens/splash/splash_screen.dart';
import 'package:hds_ptcl/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/login_request.dart';
import 'themes/ThemeController.dart';

class Constant {
  Constant._();

  // Access the ThemeController dynamically using GetX
  static final ThemeController themeController = Get.find<ThemeController>();

  // Now, instead of static constants, you get the dynamic colors from ThemeController
  static Color get primaryColor => themeController.primaryColor.value;

  static Color get secondaryColor => themeController.secondaryColor.value;

  static Color get textColor => themeController.textColor.value;

  static Color get chooserColor => themeController.backgroundColor.value;

  static const double padding = 5;
  static const double avatarRadius = 5;

  // Back icon widget
  static Widget backIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  // Power icon widget
  static Widget powerIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new, color: Colors.white),
      onPressed: () {
        showLogOutDialog(context);
      },
    );
  }

  // Log out button widget
  static Widget logOutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showLogOutDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'LogOut',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  // App bar widget
  static Widget appBarWidget(BuildContext context, String title) {
    return Row(
      children: [
        backIcon(context),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // App bar widget for main screen
  static Widget appBarWidgetMainScreen(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Container(),
        Container(),
        Container(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    height: 0.8,
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        logOutButton(context),
      ],
    );
  }

  // Remove user data and navigate to the SplashScreen
  static void removeUserData(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('userdata');
    signIn = SignIn();
    await sharedPreferences.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
      (Route<dynamic> route) => false, // Removes all previous routes
    );
  }

  // Log out dialog
  static showLogOutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Do you want to Logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No', style: TextStyle(color: Constant.primaryColor)),
          ),
          TextButton(
            onPressed: () {
              removeUserData(context);
            },
            child: Text('Yes', style: TextStyle(color: Constant.primaryColor)),
          ),
        ],
      ),
    );
  }
}
