import 'package:flutter/material.dart';
import 'package:librarymanagement/models/func.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  String matricno = "HC20200200832";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer'),
        backgroundColor: Colors.blue[800],
      ),
      body: SafeArea(
        child: SizedBox(
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
                ),
                SizedBox(
                  height: 20,
                ),
                Text('(A case study of Federal Polytechnic Ede)'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Developer',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("OBIALOR NGOZI BLESSING"),
                SizedBox(
                  height: 10,
                ),
                Text(matricno),
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
                Container(child: Text('J B EKUEWA')),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
