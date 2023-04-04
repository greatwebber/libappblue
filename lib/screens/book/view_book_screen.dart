import 'package:flutter/material.dart';
import 'package:librarymanagement/components/flash_toast.dart';
import 'package:librarymanagement/components/rounder_button.dart';
import 'package:librarymanagement/constants.dart';
import 'package:librarymanagement/models/category_books.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:librarymanagement/models/func.dart';

class ViewBookScreen extends StatefulWidget {
  final String bookTitle;
  final String bookId;
  final String quatity;
  final String authorName;
  final String publicationName;
  final String bookPage;
  final String bookCat;

  const ViewBookScreen(
      {super.key,
      required this.bookTitle,
      required this.bookId,
      required this.quatity,
      required this.authorName,
      required this.publicationName,
      required this.bookPage,
      required this.bookCat});

  @override
  State<ViewBookScreen> createState() => _ViewBookScreenState();
}

class _ViewBookScreenState extends State<ViewBookScreen> {
  bool loading = false;

  void placeBook(String userId, bookId) async {
    try {
      var url =
          Uri.parse('$apiUrl/place-book.php?user_id=$userId&book_id=$bookId');
      var response = await http.get(url);

      var data = jsonDecode(response.body.toString());

      var status = data['status'];
      var message = data['message'];

      if (status == "success") {
        setState(() {
          loading = false;
        });

        ShowToast.error(message);
      }
    } catch (e) {
      print(e);
      ShowToast.error("No internet");
      // setState(() {
      //   loading = false;
      // });
    }
  }

  showPlaceModal() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Place a Book",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 36,
                  ),
                  Text("Are you sure you want to order the book ?"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: (() {
                                    setState(() {
                                      loading = false;
                                    });

                                    placeBook(userId, widget.bookId);
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            'YES',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ElevatedButton(
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'No',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var q = widget.quatity;
    final notAvailable = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        "Not Available",
        style: const TextStyle(color: Colors.white),
      ),
    );

    var bookname = widget.bookTitle;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "$bookname Books",
            style: const TextStyle(fontSize: 25.0),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: size.height * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/library-shelf.jpg"),
                        fit: BoxFit.fill,
                      ),
                    )),
                Container(
                  // height: size.height,
                  padding: const EdgeInsets.all(40.0),
                  width: size.width,
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(58, 66, 86, .9)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // const SizedBox(height: 100.0),
                        const Icon(
                          Icons.my_library_books,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        const SizedBox(
                          width: 90.0,
                          child: Divider(color: Colors.green),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.bookTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 45.0),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Expanded(
                              flex: 1,
                              child: LinearProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(209, 224, 224, 0.2),
                                  value: 23,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.green)),
                            ),
                            Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      widget.authorName,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    "${widget.quatity} Remaining",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            (int.parse(q) <= 0)
                                ? notAvailable
                                : Container(
                                    padding: const EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      "Available",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.all(40.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Wikipedia",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: size.width * 0.5,
              child: RoundedButton(
                press: (() {
                  showPlaceModal();
                }),
                text: 'Place',
              ),
            )
          ],
        ));
  }
}
