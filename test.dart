import 'package:flutter/material.dart';

class BookCategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const BookCategoryCard({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 1.0,
                  spreadRadius: 2.0)
            ]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.book_online_outlined, size: 20),
                      Expanded(
                          child: Text(title,
                              style: Theme.of(context).textTheme.headline6)),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: press),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
