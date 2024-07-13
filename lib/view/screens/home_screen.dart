import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/model/repository/schedule_repository.dart';
import 'package:schedule_app_flutter/view/screens/loading_screen.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/heading_text.dart';
import 'package:schedule_app_flutter/view/widgets/light_text.dart';
import 'package:schedule_app_flutter/view/widgets/schedule_card_item.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';

import '../../model/data/schedule.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_bloc.dart';
import '../../viewModel/schedule_state.dart';

class HomeScreen extends StatelessWidget {
  final ScheduleRepository repository;
  const HomeScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    Helper helper = Helper();
    return
      Scaffold(body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if(state is ScheduleError){
            helper.showSnackBar(context, state.error);
          }
          return SafeArea(
              child: Stack(
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(12.0), child: _buildMainContent((state is SchedulesLoaded) ? state.schedules : [])),
              if(state is ScheduleInitial || state is SchedulesLoading)const LoadingScreen()
            ],
          ));
        },
      )
    );
  }

  Widget _buildMainContent(List<Schedule> schedules) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            const HeadingText(text: 'Monday', size: 35, color: Colors.black87),
            // const SizedBox(height: 16,),
            const BodyText(text: '00.00am', size: 24, color: Colors.black87),
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
                  text: 'Your Schedule Today', size: 16, color: Colors.black87),
              _buildListContent(schedules),
            ] else
              // if(schedules==null || schedules.isEmpty)
              const Expanded(
                child: Center(
                  child: TitleText(
                      text: "You don't have any schedule today",
                      size: 18,
                      color: Colors.black87),
                ),
              )
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
