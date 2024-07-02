import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/day_card_item.dart';
import 'package:schedule_app_flutter/view/widgets/schedule_card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ScheduleCardItem(onTap: (){}, scheduleName: 'Apa aja', startTime: '10.00am',),
            DayCardItem(onTap: (){}, day: 6)
          ],
        )
    );
  }
}
