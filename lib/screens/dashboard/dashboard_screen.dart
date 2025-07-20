import 'dart:io';

import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/body.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
