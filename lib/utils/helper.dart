import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

class Helper {
  String getDayName(int day) {
    switch (day) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Invalid day';
    }
  }

  String getDayCountFormat(int day) {
    int dayIndex = day + 1;
    switch (dayIndex) {
      case 1:
        return '${dayIndex}st';
      case 2:
        return '${dayIndex}nd';
      case 3:
        return '${dayIndex}rd';
      default:
        return '${dayIndex}th';
    }
  }

  void showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: BodyText(text: message, size: 14, color: Colors.white)),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context, String title, String content) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TitleText(text: title, size: 20, color: Colors.black87),
          content: Text(content, style: const TextStyle(fontFamily: 'Goli')),
          actions: <Widget>[
            TextButton(
              child: const TitleText(text: 'Cancel', size: 14, color: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const TitleText(text: 'Confirm', size: 14, color: Colors.blue),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
