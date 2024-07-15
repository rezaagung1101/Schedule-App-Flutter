import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/view/screens/loading_screen.dart';
import 'package:schedule_app_flutter/viewModel/schedule_bloc.dart';

import '../../model/data/schedule.dart';
import '../../model/repository/schedule_repository.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_state.dart';
import '../widgets/heading_text.dart';
import '../widgets/light_text.dart';
import '../widgets/schedule_card_item.dart';

class DetailDayScreen extends StatelessWidget {
  DetailDayScreen({super.key, required this.day, required this.repository});
  final int day;
  final ScheduleRepository repository;
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScheduleBloc(repository),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleError) helper.showSnackBar(context, state.error);
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
    List<Schedule> temp = [
      Schedule(scheduleName: "Schedule 1", day: 2, startTime: "11.00", endTime: "12.00", note: "Catatan"),
      Schedule(scheduleName: "Schedule 2", day: 2, startTime: "11.00", endTime: "12.00", note: "Catatan"),
      Schedule(scheduleName: "Schedule 3", day: 2, startTime: "11.00", endTime: "12.00", note: "Catatan"),
      Schedule(scheduleName: "Schedule 4", day: 2, startTime: "11.00", endTime: "12.00", note: "Catatan"),
      Schedule(scheduleName: "Schedule 5", day: 2, startTime: "11.00", endTime: "12.00", note: "Catatan"),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        HeadingText(text: helper.getDayName(day), size: 35, color: Colors.black87),
        const SizedBox(height: 16),
        const LightText(
            text: 'Your Schedule Today', size: 16, color: Colors.black87),
        _buildListContent(temp),
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
                    onTap: () {},
                    scheduleName: schedule.scheduleName,
                    startTime: schedule.startTime),
              );
            }),
      ),
    );
  }


}
