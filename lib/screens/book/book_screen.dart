import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanagement/models/category_books.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/book/components/category_book_card.dart';
import 'package:librarymanagement/screens/book/view_book_screen.dart';

class BookScreen extends StatefulWidget {
  final String categoryName;
  final String id;

  const BookScreen({super.key, required this.categoryName, required this.id});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Future<List<CategoryBook>> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('$apiUrl/book.php?catId=${widget.id}'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => CategoryBook.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var cname = widget.categoryName;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "$cname Books",
            style: const TextStyle(fontSize: 25.0),
          ),
          backgroundColor: Colors.black,
        ),
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
                                    category: cname,
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
                                          bookCat: cname,
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
