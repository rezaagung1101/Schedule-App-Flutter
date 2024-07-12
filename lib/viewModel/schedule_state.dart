import 'package:equatable/equatable.dart';
import '../model/data/schedule.dart';
abstract class ScheduleState extends Equatable{
  const ScheduleState();
  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class SchedulesLoading extends ScheduleState {}

class SchedulesLoaded extends ScheduleState {
  final List<Schedule> schedules;

  const SchedulesLoaded(this.schedules);
  @override
  List<Object> get props => [schedules];
}

class ScheduleError extends ScheduleState {
  final String error;

  const ScheduleError(this.error);
  @override
  List<Object> get props => [error];
}
