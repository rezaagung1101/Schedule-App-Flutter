import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/repository/schedule_repository.dart';
import '../../viewModel/schedule_bloc.dart';
import 'add_schedule_screen.dart';
import 'home_screen.dart';
import 'list_day_screen.dart';

class MainScreen extends StatefulWidget {
  final ScheduleRepository repository;

  const MainScreen({super.key, required this.repository});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  // late ScheduleBloc _scheduleBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens = [
      HomeScreen(
        repository: widget.repository,
      ),
      BlocProvider(
        create: (context) => ScheduleBloc(widget.repository),
        child: const AddScheduleScreen(),
      ),
      ListDayScreen(
        repository: widget.repository,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: 'List'),
        ],
      ),
    );
  }
}
