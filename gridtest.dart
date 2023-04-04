import 'package:flutter/material.dart';
import 'package:librarymanagement/constants.dart';
import 'package:librarymanagement/models/categories.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/category/components/categories_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<List<AllCategory>> fetchAlbum() async {
    final response = await http.get(Uri.parse('$apiUrl/category.php'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => AllCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        appBar: AppBar(
          title: const Text(
            'Category',
            style: TextStyle(fontSize: 25.0),
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<AllCategory>>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 1,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.teal[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: Text("Hello",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  )),
                            ],
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const LinearProgressIndicator();
                },
              ),
            ),
          ],
        ));
  }
}
