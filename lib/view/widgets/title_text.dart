import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text, required this.size, required this.color});

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Goli',
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: size,
      ),
      maxLines: 1,
    );
  }
}
