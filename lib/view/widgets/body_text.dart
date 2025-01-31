import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  const BodyText({super.key, required this.text, required this.size, required this.color});

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Goli',
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: size,
      ),
      maxLines: 1,
    );
  }
}
