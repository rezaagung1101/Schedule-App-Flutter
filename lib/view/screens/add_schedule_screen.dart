import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/view/widgets/button_section.dart';
import 'package:schedule_app_flutter/view/widgets/button_time_picker.dart';

import '../../model/data/schedule.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_bloc.dart';
import '../../viewModel/schedule_event.dart';
import '../../viewModel/schedule_state.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _scheduleNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FixedExtentScrollController _extentScrollController =
      FixedExtentScrollController();
  int _selectedDayIndex = 0;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  Helper helper = Helper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ScheduleBloc>().stream.listen((state) {
      if (state is SchedulesLoaded) {
        // Schedule added successfully
        helper.showSnackBar(context, 'Schedule added successfully!');
        // Navigator.pop(context); // Optionally navigate back
      } else if (state is ScheduleError) {
        // Error occurred while adding schedule
        helper.showSnackBar(context, state.error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const BodyText(
                      text: 'Add New Schedule', size: 22, color: Colors.black87),
                  const SizedBox(height: 16.0),
                  buildDaySpinner(),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _scheduleNameController,
                    decoration: InputDecoration(
                        labelText: 'Schedule Name',
                        labelStyle: const TextStyle(fontFamily: 'Goli'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Schedule name can't be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _noteController,
                    decoration: InputDecoration(
                        labelText: 'Add note here',
                        labelStyle: const TextStyle(fontFamily: 'Goli'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonTimePicker(
                          onTap: _selectStartTime,
                          text: 'Start Time',
                          selectedTime: selectedStartTime,
                          icon: Icons.play_circle,
                        ),
                      ),
                      Expanded(
                        child: ButtonTimePicker(
                          onTap: _selectEndTime,
                          text: 'End Time',
                          selectedTime: selectedEndTime,
                          icon: Icons.stop_circle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ButtonSection(onTap: _confirmAddSchedule, text: 'Save', mainColor: Colors.blue)
                ],
              ),
            )),
      ),
    ));
  }

  Future<TimeOfDay?> showCustomTimePicker(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    return pickedTime;
  }

  Future<void> _selectStartTime() async {
    final pickedTime = await showCustomTimePicker(context);
    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final pickedTime = await showCustomTimePicker(context);
    if (pickedTime != null && pickedTime != selectedEndTime) {
      setState(() {
        selectedEndTime = pickedTime;
      });
    }
  }

  void _confirmAddSchedule() async{
    if (_formKey.currentState!.validate()) {
      if (selectedStartTime != null && selectedEndTime != null) {
          bool? result = await helper.showConfirmationDialog(
            context,
            'Confirm Add Task',
            'Are you sure you want to add this task?',
          );
          if (result == true) {
            _addSchedule();
          }
      } else {
        helper.showSnackBar(context, 'Start & End Time Required!');
      }
    }
  }

  void _addSchedule() async{
    final scheduleName = _scheduleNameController.text;
    final note = _noteController.text;
    final startTime = helper.timeOfDayToString(selectedStartTime!);
    final endTime = helper.timeOfDayToString(selectedEndTime!);
    final schedule = Schedule(
      scheduleName: scheduleName,
      day: _selectedDayIndex,
      startTime: startTime,
      endTime: endTime,
      note: note.toString(),
    );
    //add schedule not yet implemented
    BlocProvider.of<ScheduleBloc>(context).add(AddSchedule(schedule));
  }

  Widget buildDaySpinner() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Stack(
                children: [
                  ListWheelScrollView.useDelegate(
                    controller: _extentScrollController,
                    itemExtent: 35,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 32),
                          alignment: Alignment.centerLeft,
                          child: BodyText(
                            text: Constants.days[index],
                            size: 18,
                            color: Colors.black87,
                          ),
                        );
                      },
                      childCount: Constants.days.length,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.95),
                              Colors.white.withOpacity(0.0),
                              Colors.white.withOpacity(0.95),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            right: 5,
            child: Icon(Icons.swipe_vertical_outlined, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

