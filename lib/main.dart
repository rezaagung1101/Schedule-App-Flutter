import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      // BlocProvider(
      // create: (context) => ScheduleBloc()..add(LoadSchedules()),
      // child:
      MaterialApp(
        title: 'Scheduler App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      // ),
    );
  }
}

