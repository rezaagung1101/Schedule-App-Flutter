import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/view/widgets/spinner_day.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';
import '../../model/data/schedule.dart';
import '../../model/repository/schedule_repository.dart';
import '../../utils/helper.dart';
import '../../viewModel/schedule_bloc.dart';
import '../../viewModel/schedule_state.dart';
import '../widgets/button_section.dart';
import '../widgets/button_time_picker.dart';
import '../widgets/title_text.dart';

/**
 *
 * Masih belum bisa update ke db
 */
class UpdateScheduleScreen extends StatefulWidget {
  UpdateScheduleScreen({super.key, required this.schedule});

  final Schedule schedule;

  @override
  State<UpdateScheduleScreen> createState() => _UpdateScheduleScreenState();
}

class _UpdateScheduleScreenState extends State<UpdateScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _scheduleNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  late int _selectedDayIndex;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    _selectedDayIndex = widget.schedule.day;
    _scheduleNameController.text = widget.schedule.scheduleName;
    _noteController.text = widget.schedule.note;
    _selectedStartTime = helper.stringToTimeOfDay(widget.schedule.startTime);
    _selectedEndTime = helper.stringToTimeOfDay(widget.schedule.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const TitleText(
          text: "Update Schedule",
          size: 20,
          color: Colors.black87,
        ),
      ),
      body: BlocProvider(
        create: (context) => ScheduleBloc(ScheduleRepository()),
        child: BlocListener<ScheduleBloc, ScheduleState>(
          listener: (context, state) {
            if (state is SchedulesLoaded) {
              // Schedule updated successfully
              helper.showSnackBar(context, 'Schedule updated successfully!');
              Navigator.pop(context); // Optionally navigate back
            } else if (state is ScheduleError) {
              // Error occurred while updating schedule
              helper.showSnackBar(context, state.error);
            }
          },
          child: BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              return _buildMainContent(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinnerDay(
              selectedDayIndex: _selectedDayIndex,
              onDayChanged: (index) {
                setState(() {
                  _selectedDayIndex = index;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _scheduleNameController,
              decoration: InputDecoration(
                labelText: 'Schedule Name',
                labelStyle: const TextStyle(fontFamily: 'Goli'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
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
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ButtonTimePicker(
                    onTap: _selectStartTime,
                    text: widget.schedule.startTime,
                    selectedTime: _selectedStartTime,
                    icon: Icons.play_circle,
                  ),
                ),
                Expanded(
                  child: ButtonTimePicker(
                    onTap: _selectEndTime,
                    text: widget.schedule.endTime,
                    selectedTime: _selectedEndTime,
                    icon: Icons.stop_circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ButtonSection(
              onTap: () => _confirmUpdateSchedule(context),
              text: 'Save',
              mainColor: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
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
    if (pickedTime != null && pickedTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final pickedTime = await showCustomTimePicker(context);
    if (pickedTime != null && pickedTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    }
  }

  void _confirmUpdateSchedule(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_selectedStartTime != null && _selectedEndTime != null) {
        bool? result = await helper.showConfirmationDialog(
          context,
          'Confirm Update Schedule',
          'Are you sure you want to update this schedule?',
        );
        if (result == true) {
          _updateSchedule(context);
        }
      } else {
        helper.showSnackBar(context, 'Start & End Time Required!');
      }
    }
  }

  void _updateSchedule(BuildContext context) async {
    final scheduleName = _scheduleNameController.text;
    final note = _noteController.text;
    final startTime = helper.timeOfDayToString(_selectedStartTime!);
    final endTime = helper.timeOfDayToString(_selectedEndTime!);
    final schedule = Schedule(
      scheduleName: scheduleName,
      day: _selectedDayIndex,
      startTime: startTime,
      endTime: endTime,
      note: note.toString(),
    );
    BlocProvider.of<ScheduleBloc>(context).add(UpdateSchedule(schedule));
  }
}
