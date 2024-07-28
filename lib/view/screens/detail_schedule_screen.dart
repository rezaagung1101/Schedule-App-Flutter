import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/model/data/schedule.dart';
import 'package:schedule_app_flutter/view/screens/update_schedule_screen.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

class DetailScheduleScreen extends StatelessWidget {
  const DetailScheduleScreen({super.key, required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const TitleText(
          text: "Schedule Detail", size: 20, color: Colors.black87,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 8, 16),
        child: Column(
          children: [
            _detailSection(Icons.menu_book, "Schedule name", schedule.scheduleName),
            const SizedBox(height: 32,),
            _detailSection(Icons.access_time, "Time", "${schedule.startTime} - ${schedule.endTime}"),
            const SizedBox(height: 32,),
            _detailSection(Icons.notes_rounded, "Note", schedule.note),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateScheduleScreen(schedule: schedule,)));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }


  Widget _detailSection(IconData icon, String title, String description) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 40, color: Colors.black54,),
        const SizedBox(width: 24,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          BodyText(text: title, size: 16, color: Colors.grey),
          BodyText(text: (description.isNotEmpty) ? description :"-", size: 16, color: Colors.black87)
        ],))
      ],
    );
  }
}
