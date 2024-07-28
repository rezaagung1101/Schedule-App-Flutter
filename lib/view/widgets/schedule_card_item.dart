import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';

class ScheduleCardItem extends StatelessWidget {
  const ScheduleCardItem(
      {super.key,
      required this.onTap,
      required this.scheduleName,
      required this.startTime});

  final VoidCallback onTap;
  final String scheduleName;
  final String startTime;

  @override
  Widget build(BuildContext context) {
    return
        Card(
          elevation: 2,
          color: Colors.blue[50],
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.access_time,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  BodyText(text: startTime, size: 16, color: Colors.black87),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: BodyText(
                          text: scheduleName, size: 16, color: Colors.black87)),
                ],
              ),
            ),
          ),
        );
  }
}
