import 'package:flutter/material.dart';
import 'package:librarymanagement/constants.dart';

class BookCategoryCard extends StatelessWidget {
  final String title;
  final String author;
  final String category;
  final String q;
  final VoidCallback press;

  const BookCategoryCard({
    Key? key,
    required this.title,
    required this.press,
    required this.author,
    required this.category,
    required this.q,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final notAvailable = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          color: Colors.red,
          borderRadius: BorderRadius.circular(5.0)),
      child: const Text(
        "Not Available",
        style: TextStyle(color: Colors.white),
      ),
    );
    return Card(
      color: kPrimaryLightColor,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.book, size: 20),
                        Expanded(
                          child: Text(title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.person, size: 20),
                        Text(author,
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.category_rounded, size: 20),
                        Text(category,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  (int.parse(q) <= 0)
                      ? Container()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: press,
                          child: Column(
                            children: const [
                              Text('View'),
                            ],
                          ),
                        ),
                  Column(
                    children: <Widget>[
                      (int.parse(q) <= 0)
                          ? notAvailable
                          : Container(
                              padding: const EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Text(
                                "Available",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
