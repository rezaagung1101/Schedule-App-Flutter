import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/light_text.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

import '../../utils/helper.dart';

class DayCardItem extends StatelessWidget {
  const DayCardItem({super.key, required this.onTap, required this.day});

  final VoidCallback onTap;
  final int day;

  @override
  Widget build(BuildContext context) {
    Helper helper = Helper();
    return Card(
        color: Colors.blue[100],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.white38,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TitleText(text: helper.getDayName(day),
                      size: 20,
                      color: Colors.black87),
                ),
                LightText(text: "${helper.getDayCountFormat(day)} of the week", size: 14, color: Colors.black54)
              ],
            ),
          ),
        )
    );
  }
}
