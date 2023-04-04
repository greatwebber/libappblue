import 'package:flutter/material.dart';
import 'package:librarymanagement/models/func.dart';

class DeveloperScreen extends StatelessWidget {
  // const DeveloperScreen({super.key});
  final full_name = [
    "AKINDOYENI SOLA OLAOLUWA",
    "Ayoade Abolade omolade",
    "Samuel oni ojo"
  ];
  final matricno = ["CS20200201927", "Cs20200201028", "Cs20200202673"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Developers'),
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: full_name.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                minVerticalPadding: 10,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                title: Text(full_name[index]),
                subtitle: Row(
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(matricno[index]),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text('ND 2 DPT'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage("$profileUrl${matricno[index]}.jpg")),
              ));
            }),
      ),
    );
  }
}
