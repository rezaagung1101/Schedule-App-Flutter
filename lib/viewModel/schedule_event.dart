import 'package:equatable/equatable.dart';
import '../model/data/schedule.dart';

abstract class ScheduleEvent extends Equatable{
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class LoadSchedules extends ScheduleEvent{}

class AddSchedule extends ScheduleEvent{
  final Schedule schedule;

  const AddSchedule(this.schedule);

  @override
  List<Object> get props => [schedule];
}