import 'package:schedule_app_flutter/model/data/schedule.dart';
import '../database/database_helper.dart';

class ScheduleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertSchedule(Schedule schedule) async {
    await _databaseHelper.insertSchedule(schedule);
  }

  Future<void> updateSchedule(Schedule schedule) async {
    await _databaseHelper.updateSchedule(schedule);
  }

  Future<void> deleteSchedule(String id) async {
    await _databaseHelper.deleteSchedule(id);
  }

  Future<List<Schedule>> getAllSchedules() async {
    return _databaseHelper.getAllSchedule();
  }
}
