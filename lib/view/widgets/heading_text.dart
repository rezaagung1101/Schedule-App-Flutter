import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText(this.text, this.size, this.color, {super.key});
  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Goli',
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: size,
      ),
      maxLines: 1,
    );
  }
}
