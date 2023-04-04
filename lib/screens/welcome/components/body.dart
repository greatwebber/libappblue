import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagement/components/rounder_button.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/developer.dart';
import 'package:librarymanagement/screens/login/login_screen.dart';
import 'package:librarymanagement/screens/welcome/components/background.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: SizedBox(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  "assets/images/fpelogo.png",
                  width: size.width * 0.35,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Project Topic',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "$appName",
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '(A case study of Federal Polytechnic Ede)',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    width: size.width * 0.6,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Supervised By',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/fpelogo.png'),
                  radius: 60,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(child: Text('Mrs Oluwatosin Adefunke Oluwatobi')),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    width: size.width * 0.6,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('ABOUT DEVELOPERS'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DeveloperScreen();
                        }));
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
