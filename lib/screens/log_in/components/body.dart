import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hds_ptcl/screens/log_in/components/sign_in_form.dart';
import '../../../constants.dart'; // Import the updated Constant class for dynamic colors
import '../../../size_config.dart';
import '../../../themes/ThemeController.dart'; // Import the ThemeController for dynamic colors
import 'package:get/get.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Constant.primaryColor,
                // Use dynamic primary color from Constant
                Constant.secondaryColor,
                // Use dynamic secondary color from Constant
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      // Text color remains white for contrast
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                          ),
                          child: SignInForm(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
