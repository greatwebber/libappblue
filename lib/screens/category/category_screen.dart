import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanagement/components/buttom_navigation.dart';
import 'package:librarymanagement/components/flash_toast.dart';
import 'package:librarymanagement/constants.dart';
import 'package:librarymanagement/models/categories.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/book/book_screen.dart';
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
      throw ShowToast.error("Failed to load data");
    }
  }

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
        bottomNavigationBar: ButtomNavigation(),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<AllCategory>>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CategoriesCard(
                                    title: snapshot.data![index].categoryName
                                        .toString(),
                                    press: (() {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => BookScreen(
                                            categoryName: snapshot
                                                .data![index].categoryName
                                                .toString(),
                                            id: snapshot.data![index].id
                                                .toString()),
                                      ));
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
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
