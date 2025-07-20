import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hds_ptcl/screens/dashboard/dashboard_screen.dart';
import 'package:hds_ptcl/screens/log_in/sign_in_screen.dart';
import 'package:hds_ptcl/screens/splash/splash_screen.dart';
import 'package:hds_ptcl/themes/ThemeController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController()); // Initialize the theme controller
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(
    ThemeController(),
  ); // Get the theme controller

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HDS KFC',
      theme: ThemeData(
        // Using the dynamic color values from ThemeController
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(name: SplashScreen.routeName, page: () => LogInScreen()),
        GetPage(name: '/login', page: () => LogInScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
      ],
    );
  }
}
