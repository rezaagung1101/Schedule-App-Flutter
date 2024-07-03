import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key, required this.onTap, required this.text, required this.mainColor, });

  final VoidCallback onTap;
  final String text;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: mainColor.withOpacity(0.3),
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: SizedBox(
            width: double.infinity, // Match parent width
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Button background color
                border: Border.all(color: mainColor, width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: TitleText(size: 16, text: text, color: mainColor,),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
