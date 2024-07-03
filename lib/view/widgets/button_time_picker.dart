import 'package:flutter/material.dart';

class ButtonTimePicker extends StatelessWidget {
  const ButtonTimePicker({super.key, required this.onTap, this.selectedTime, required this.text, required this.icon});
  final VoidCallback onTap;
  final TimeOfDay? selectedTime;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      splashColor: Colors.blue[100],
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Card.outlined(
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 16,
              ),
              Icon(icon, color: Colors.black87,),
              const SizedBox(
                width: 16,
              ),
              Text(
                selectedTime != null
                    ? selectedTime!
                    .format(context)
                    : text,
                style: const TextStyle(fontFamily: 'Goli'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
