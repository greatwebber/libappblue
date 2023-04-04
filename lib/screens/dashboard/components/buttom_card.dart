import 'package:flutter/material.dart';
import 'package:librarymanagement/constants.dart';

class ButtomContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback press;
  const ButtomContainer({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0)
            ]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 48.0,
                      height: 48.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ))),
                ),
                Expanded(
                    child: Center(
                  child:
                      Text(title, style: Theme.of(context).textTheme.headline6),
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
