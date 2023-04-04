import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagement/components/already_have_account_checked.dart';
import 'package:librarymanagement/components/flash_toast.dart';
import 'package:librarymanagement/components/rounded_input_field.dart';
import 'package:librarymanagement/components/rounder_button.dart';
import 'package:librarymanagement/components/rounder_password_field.dart';
import 'package:librarymanagement/components/text_field_container.dart';
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

  bool passwordVisible = false;
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // SvgPicture.asset(
                  //   "assets/icons/login.svg",
                  //   height: size.height * 0.35,
                  // ),
                  Image.asset(
                    'assets/images/library.png',
                    height: size.height * 0.35,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  TextFieldContainer(
                    child: TextField(
                      controller: usernameInput,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10, // define o tipo de teclado utilizado
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Matric No",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: passwordInput,
                      onChanged: (value) {},
                      style: TextStyle(fontSize: 18),
                      minLines: 1,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            }),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  loading
                      ? CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: size.width * 0.8,
                          child: ElevatedButton(
                              onPressed: (() {
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(Icons.login),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              )),
                        ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
