import 'package:equatable/equatable.dart';

import '../model/data/schedule.dart';

abstract class ScheduleEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadSchedules extends ScheduleEvent {}

class LoadSchedulesByDay extends ScheduleEvent {
  final String day;

  LoadSchedulesByDay(this.day);
}

class LoadScheduledDays extends ScheduleEvent {}

class AddSchedule extends ScheduleEvent {
  final Schedule schedule;

  AddSchedule(this.schedule);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;

  UpdateSchedule(this.schedule);
}

class DeleteSchedule extends ScheduleEvent {
  final String id;

  DeleteSchedule(this.id);
}
