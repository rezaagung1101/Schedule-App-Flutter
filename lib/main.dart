import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/model/repository/schedule_repository.dart';
import 'package:schedule_app_flutter/view/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ScheduleRepository repository = ScheduleRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      // BlocProvider(
      // create: (context) => ScheduleBloc(repository)..add(LoadSchedules()), // Dispatch LoadSchedules event here
      // child:
      MaterialApp(
        title: 'JadwalIn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(repository: repository),
      // ),
    );
  }
}

