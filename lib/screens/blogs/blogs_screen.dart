import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanagement/components/buttom_navigation.dart';
import 'package:librarymanagement/components/flash_toast.dart';
import 'package:http/http.dart' as http;
import 'package:librarymanagement/models/category_books.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/book/components/category_book_card.dart';
import 'package:librarymanagement/screens/book/view_book_screen.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  Future<List<CategoryBook>> fetchAlbum() async {
    final response = await http.get(Uri.parse('$apiUrl/all-books.php'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => CategoryBook.fromJson(e)).toList();
    } else {
      throw ShowToast.error('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All Books",
            style: const TextStyle(fontSize: 25.0),
          ),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: ButtomNavigation(),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<CategoryBook>>(
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
                                  child: BookCategoryCard(
                                    title: snapshot.data![index].bookName
                                        .toString(),
                                    author: snapshot.data![index].authorName
                                        .toString(),
                                    category: snapshot.data![index].bookCategory
                                        .toString(),
                                    q: snapshot.data![index].bookQuatity
                                        .toString(),
                                    press: (() {
                                      Navigator.of(context)
                                          .push(SlideRightRoute(
                                        page: ViewBookScreen(
                                          bookTitle: snapshot
                                              .data![index].bookName
                                              .toString(),
                                          bookId: snapshot.data![index].bookId
                                              .toString(),
                                          authorName: snapshot
                                              .data![index].authorName
                                              .toString(),
                                          quatity: snapshot
                                              .data![index].bookQuatity
                                              .toString(),
                                          publicationName: snapshot
                                              .data![index].publicationName
                                              .toString(),
                                          bookPage: snapshot
                                              .data![index].bookPages
                                              .toString(),
                                          bookCat: snapshot
                                              .data![index].bookCategory
                                              .toString(),
                                        ),
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
