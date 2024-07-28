import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/view/screens/loading_screen.dart';
import 'package:schedule_app_flutter/viewModel/schedule_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';

import '../../model/data/schedule.dart';
import '../../model/repository/schedule_repository.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_state.dart';
import '../widgets/button_section.dart';
import '../widgets/heading_text.dart';
import '../widgets/light_text.dart';
import '../widgets/schedule_card_item.dart';
import 'detail_schedule_screen.dart';

class DetailDayScreen extends StatelessWidget {
  DetailDayScreen({super.key, required this.day, required this.repository});

  final int day;
  final ScheduleRepository repository;
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ScheduleBloc(repository)..add(LoadSchedulesByDay(day.toString())),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleError)
              helper.showSnackBar(context, state.error);
            return SafeArea(
                child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildMainContent(
                        (state is SchedulesLoaded) ? state.schedules : [])),
                if (state is ScheduleInitial || state is SchedulesLoading)
                  const LoadingScreen()
              ],
            ));
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(List<Schedule> schedules) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        HeadingText(
            text: helper.getDayName(day), size: 35, color: Colors.black87),
        const SizedBox(height: 16),
        const LightText(
            text: 'Your Schedules', size: 16, color: Colors.black87),
        Expanded(child: _buildListContent(schedules)),
        Builder(
          builder: (BuildContext context) {
            return ButtonSection(
              onTap: () {
                Navigator.pop(context);
              },
              text: "Back",
              mainColor: Colors.lightBlue,
            );
          },
        ),
      ],
    );
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScheduleScreen(schedule: schedule)));
                    },
                    scheduleName: schedule.scheduleName,
                    startTime: schedule.startTime),
              );
            }),
      ),
    );
  }
}
