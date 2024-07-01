import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/schedule_card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScheduleCardItem(onTap: (){}, scheduleName: 'Apa aja', startTime: '10.00am',)
      ),
    );
  }
}
