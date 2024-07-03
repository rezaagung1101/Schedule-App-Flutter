import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/heading_text.dart';
import 'package:schedule_app_flutter/view/widgets/light_text.dart';
import 'package:schedule_app_flutter/view/widgets/schedule_card_item.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

import '../../model/data/schedule.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Schedule> schedules = [
      // Schedule(scheduleName: "Makan", day: 1, startTime: "00.00", endTime: "00.00", note: "note"),
      // Schedule(scheduleName: "Tidur", day: 2, startTime: "00.00", endTime: "00.00", note: "note"),
      // Schedule(scheduleName: "Belajar", day: 3, startTime: "00.00", endTime: "00.00", note: "note"),
      // Schedule(scheduleName: "Membaca", day: 4, startTime: "00.00", endTime: "00.00", note: "note"),
    ];
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        // child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              HeadingText(text: 'Monday', size: 35, color: Colors.black87),
              // const SizedBox(height: 16,),
              BodyText(text: '00.00am', size: 24, color: Colors.black87),
              const SizedBox(
                height: 16,
              ),
              const LightText(
                  text: 'Nearest Schedule', size: 16, color: Colors.black87),
              const SizedBox(
                height: 16,
              ),
              if (schedules.isNotEmpty) ...[
                const LightText(
                    text: 'Your Schedule Today',
                    size: 16,
                    color: Colors.black87),
                _buildListContent(schedules),
              ] else
                const Expanded(
                  child: Center(
                    child: TitleText(
                        text: "You don't have any schedule today",
                        size: 18,
                        color: Colors.black87),
                  ),
                )
            ],
          // ),
        ),
      ),
    ));
  }

  Widget _buildListContent(List<Schedule> schedules) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ScheduleCardItem(
                    onTap: () {},
                    scheduleName: schedule.scheduleName,
                    startTime: schedule.startTime),
              );
            }),
      ),
    );
  }
}
