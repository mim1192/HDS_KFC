import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apis/dio_services.dart';
import '../../../model/login_request.dart';
import '../../../model/tenat.dart';
import '../../../size_config.dart';
import 'package:line_icons/line_icons.dart';
import '../../../themes/ThemeController.dart';
import '../../../constants.dart';

SignIn signIn = SignIn();
late SharedPreferences sharedPreferences;
bool obscureText = true;

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final ThemeController themeController = Get.put(
    ThemeController(),
  ); // Initialize the theme controller
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Hardcoded sample TenAt data for the dropdown
  List<TenAt> serviceTypes = [
    TenAt(username: "User1", password: "pass123", tenantId: 1),
    TenAt(username: "User2", password: "pass456", tenantId: 2),
    TenAt(username: "User3", password: "pass789", tenantId: 3),
  ];

  TenAt? selectedTenant; // Track the selected TenAt object

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // Dropdown for service types (tenants)
  Widget serviceTypeDropDown() {
    return Column(
      children: [
        titleOfFields('Init*'),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        Container(
          height: SizeConfig.screenHeight * 0.075,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Obx(() {
                    return DropdownButton<TenAt?>(
                      isExpanded: true,
                      value: selectedTenant,
                      hint: Text('Select Tenant'),
                      items: serviceTypes.map((TenAt e) {
                        return DropdownMenuItem<TenAt>(
                          value: e,
                          child: Text(
                            e.username ?? 'Unknown User',
                            style: TextStyle(
                              color: themeController.primaryColor.value,
                            ), // Use dynamic color
                          ),
                        );
                      }).toList(),
                      onChanged: (TenAt? val) {
                        setState(() {
                          selectedTenant = val; // Update selected tenant
                        });

                        // Update the theme based on the selected tenant
                        themeController.updateTheme(
                          Color(0xffcb005d),
                          Color(0xffd50600),
                          Color(0xFF644600),
                          Color(0xFF002379),
                        );
                      },
                      onTap: () {
                        FocusScope.of(
                          context,
                        ).unfocus(); // Unfocus the field when tapped
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        Divider(thickness: 2),
      ],
    );
  }

  // Welcome message
  Widget welcome() {
    return Column(
      children: [
        Text(
          'WELCOME TO',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: Constant.primaryColor, // Use dynamic color from Constant
          ),
        ),
        Text(
          'KFC',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: getProportionateScreenWidth(20),
            color: Constant.primaryColor, // Use dynamic color from Constant
          ),
        ),
        Text(
          'HDS KFC',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: getProportionateScreenWidth(20),
            color: Constant.primaryColor, // Use dynamic color from Constant
          ),
        ),
      ],
    );
  }

  // User name input field
  Widget buildUserNameField() {
    return Column(
      children: [
        titleOfFields('USERNAME'),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        TextFormField(
          controller: nameController,
          cursorColor: Constant.primaryColor,
          // Use dynamic color
          autofocus: false,
          maxLength: 30,
          onSaved: (input) => signIn.username = input.toString(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Username required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Enter username here...',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        Divider(thickness: 2),
      ],
    );
  }

  // Password input field
  Widget buildPasswordField() {
    return Column(
      children: [
        titleOfFields('Password'),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        TextFormField(
          controller: passwordController,
          cursorColor: Constant.primaryColor,
          // Use dynamic color
          autofocus: false,
          maxLength: 30,
          onSaved: (input) => signIn.password = input.toString(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password required';
            }
            return null;
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Enter password here...',
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? LineIcons.eyeSlash : LineIcons.eye,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        Divider(thickness: 2),
      ],
    );
  }

  // Custom title of fields
  Widget titleOfFields(String engTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          engTitle,
          style: TextStyle(
            color: Constant.primaryColor,
            fontWeight: FontWeight.bold,
          ), // Use dynamic color
        ),
      ],
    );
  }

  // Custom button to sign in
  Widget customButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          validateAndSignIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Constant.primaryColor, // Use dynamic color
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'SIGN IN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Validate and sign in user
  validateAndSignIn() async {
    // Navigate to the dashboard screen (for example)

    Navigator.pushNamed(context, '/dashboard'); // Navigate to dashboard screen
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final dioService = DioService(); // Create an instance of DioService

      final request = SignIn(
        username: nameController.text,
        password: passwordController.text,
        tenantId:
            selectedTenant?.tenantId ?? 0, // Using tenantId from selectedTenant
      );

      final result = await dioService.login(request);

      if (result.success) {
        print("✅ Login Success");
        print("🔑 Token: ${result.data['token']}"); // Example
      } else {
        print("❌ Login Failed: ${result.message}");
        // Show Snackbar/Toast with result.message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          welcome(),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          serviceTypeDropDown(), // Dropdown widget for tenant selection
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          buildUserNameField(), // Username field
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          buildPasswordField(), // Password field
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          customButton(), // Sign In button
          SizedBox(height: SizeConfig.screenHeight * 0.04),
        ],
      ),
    );
  }
}
