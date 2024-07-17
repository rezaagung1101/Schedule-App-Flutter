import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/model/repository/schedule_repository.dart';
import 'package:schedule_app_flutter/view/screens/loading_screen.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/heading_text.dart';
import 'package:schedule_app_flutter/view/widgets/light_text.dart';
import 'package:schedule_app_flutter/view/widgets/schedule_card_item.dart';
import 'package:schedule_app_flutter/view/widgets/title_text.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';

import '../../model/data/schedule.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_bloc.dart';
import '../../viewModel/schedule_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository});
  final ScheduleRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  String _currentDay = Helper.getCurrentDay();
  String _currentTime = Helper.getCurrentTime();
  int _currentDayIndex = Helper.getCurrentDayIndex();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentDay = Helper.getCurrentDay();
      _currentTime = Helper.getCurrentTime();
      _currentDayIndex = Helper.getCurrentDayIndex();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Helper helper = Helper();
    return
      Scaffold(
          body: BlocProvider(
            create: (context) => ScheduleBloc(widget.repository)..add(LoadSchedulesByDay(_currentDayIndex.toString())),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
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
                  ),
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
          HeadingText(text: _currentDay, size: 35, color: Colors.black87), //current day
          // const SizedBox(height: 16,),
          BodyText(text: _currentTime, size: 24, color: Colors.black87), //current time
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
                text: 'Your Schedules Today', size: 16, color: Colors.black87),
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

