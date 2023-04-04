import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagement/components/already_have_account_checked.dart';
import 'package:librarymanagement/components/flash_toast.dart';
import 'package:librarymanagement/components/rounded_input_field.dart';
import 'package:librarymanagement/components/rounder_button.dart';
import 'package:librarymanagement/components/rounder_password_field.dart';
import 'package:librarymanagement/constants.dart';
// import 'package:librarymanagement/components/text_field_container.dart';
// import 'package:librarymanagement/constants.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/dashboard/dashboard_screen.dart';
import 'package:librarymanagement/screens/login/components/backgroud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  // var controller;
  final usernameInput = TextEditingController();

  final passwordInput = TextEditingController();

  bool loading = false;

  void getData() async {
    setState(() {
      loading = false;
    });
    await UserDetails.getUserDetails();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DashboardScreen()));
  }

  // const LoginBody({
  void login(String username, password) async {
    try {
      var url = Uri.parse('$apiUrl/user.php?id=$username&pas=$password');
      var response = await http.get(url);
      var data = jsonDecode(response.body.toString());
      var status = data['status'];
      var message = data['message'];

      if (status == "error") {
        setState(() {
          loading = false;
        });
        ShowToast.error(message);
      } else if (status == "success") {
        setState(() {
          userId = message;
        });
        ShowToast.success('Login successfully');
        getData();
      }
    } catch (e) {
      ShowToast.error(e.toString());
    }
  }

  // Future<bool?> ShowTaost() async {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN $appName",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RounderInputField(
              hintText: "Matric No",
              icon: Icons.person,
              onChanged: (value) {},
              controller: usernameInput,
            ),
            RoundedPasswordField(
              hintText: "Password",
              icon: Icons.lock,
              onChanged: (value) {},
              controller: passwordInput,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            loading
                ? CircularProgressIndicator(
                    color: kPrimaryColor,
                  )
                : RoundedButton(
                    text: "LOGIN",
                    press: () {
                      setState(() {
                        loading = false;
                      });
                      if (usernameInput.text == "") {
                        ShowToast.error("Matric No is Required");
                      } else if (passwordInput.text == "") {
                        ShowToast.error("Password is required");
                      } else {
                        login(usernameInput.text.toString(),
                            passwordInput.text.toString());
                        setState(() {
                          loading = true;
                        });
                      }
                    }),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
