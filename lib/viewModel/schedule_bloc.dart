import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';
import 'package:schedule_app_flutter/viewModel/schedule_state.dart';
import '../model/repository/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  ScheduleBloc(this.repository) : super(ScheduleInitial());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (event is LoadSchedules) {
      yield* _mapLoadSchedulesToState();
    } else if (event is AddSchedule) {
      yield* _mapAddScheduleToState(event);
    } else if (event is UpdateSchedule) {
      yield* _mapUpdateScheduleToState(event);
    } else if (event is DeleteSchedule) {
      yield* _mapDeleteScheduleToState(event);
    }
  }

  Stream<ScheduleState> _mapLoadSchedulesToState() async* {
    yield SchedulesLoading();
    try {
      final schedules = await repository.getAllSchedules();
      yield SchedulesLoaded(schedules);
    } catch (e) {
      yield ScheduleError('Failed to load schedules: $e');
    }
  }

  Stream<ScheduleState> _mapAddScheduleToState(AddSchedule event) async* {
    try {
      await repository.insertSchedule(event.schedule);
      yield* _mapLoadSchedulesToState(); // Reload schedules after addition
    } catch (e) {
      yield ScheduleError('Failed to add schedule: $e');
    }
  }

  Stream<ScheduleState> _mapUpdateScheduleToState(UpdateSchedule event) async* {
    try {
      await repository.updateSchedule(event.schedule);
      yield* _mapLoadSchedulesToState(); // Reload schedules after update
    } catch (e) {
      yield ScheduleError('Failed to update schedule: $e');
    }
  }

  Stream<ScheduleState> _mapDeleteScheduleToState(DeleteSchedule event) async* {
    try {
      await repository.deleteSchedule(event.id);
      yield* _mapLoadSchedulesToState(); // Reload schedules after deletion
    } catch (e) {
      yield ScheduleError('Failed to delete schedule: $e');
    }
  }
}