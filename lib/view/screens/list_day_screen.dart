import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/view/screens/detail_day_screen.dart';
import 'package:schedule_app_flutter/view/widgets/day_card_item.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';

import '../../model/repository/schedule_repository.dart';
import '../../viewModel/schedule_bloc.dart';
import '../../viewModel/schedule_state.dart';
import 'loading_screen.dart';

class ListDayScreen extends StatelessWidget {
  const ListDayScreen({super.key, required this.repository});

  final ScheduleRepository repository;

  @override
  Widget build(BuildContext context) {
    List<int> scheduledDays = [1, 2, 3, 4, 6];
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScheduleBloc(repository)..add(LoadScheduledDays()),
        child:
            BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
              return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _buildListContent(
                              (state is ScheduledDaysLoaded) ? state.scheduledDays : [])),
                      // if (state is ScheduleInitial || state is SchedulesLoading)
                      //   const LoadingScreen()
                    ],
                  ));
        }),
      ),
    );
  }

  Widget _buildListContent(List<int> scheduledDays){
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: scheduledDays.length,
          itemBuilder: (context, index) {
            final day = scheduledDays[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: DayCardItem(
                  day: day,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailDayScreen(
                                repository: repository, day: day)));
                  }),
            );
          },
        ),
      ),
    );
  }
}
