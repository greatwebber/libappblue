import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: widget.textColor,
              backgroundColor: widget.color,
              minimumSize: Size(88, 36),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            onPressed: widget.press,
            child: Text(widget.text)),
      ),
    );
  }
}
