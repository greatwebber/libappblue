import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String appName = "Development of Android Based Digital Library System";

const String apiUrl = "https://mylib.mytestdomainweb.website/json";

const String profileUrl = "https://www.federalpolyede.edu.ng/passport/Reg";

String userId = '';

class UserDetails {
  static late String fullName;
  static late String matricNo;
  static late String department;
  static late String level;
  static late String contactNumber;
  static late String numIssuedBooks;

  factory UserDetails() => UserDetails._internal();
  UserDetails._internal();

  static Future<void> getUserDetails() async {
    var url = Uri.parse("$apiUrl/user_detail.php?id=$userId");
    var response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    fullName = data['full_name'];
    matricNo = data['UserName'];
    department = data['department'];
    level = data['level'];
    contactNumber = data['UserContactNumber'];
    numIssuedBooks = data['NumberOfIssuedBooks'];
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
