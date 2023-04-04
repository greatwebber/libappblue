import 'package:flutter/material.dart';
import 'package:librarymanagement/constants.dart';

class AlreadyHaveAccountChecked extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAccountChecked({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Dont have an account ?" : "Already have Account ?",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
