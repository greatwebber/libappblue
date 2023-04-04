import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final int issuedBook;
  final String iconUrl;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.press,
    this.issuedBook = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(fontSize: 20, color: Colors.black);
    return InkWell(
      onTap: press,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                iconUrl,
                height: 90,
              ),
            ),
            Text(
              "$title",
              style: cardTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
