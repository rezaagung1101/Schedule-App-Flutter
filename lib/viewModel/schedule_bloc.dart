import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';
import 'package:schedule_app_flutter/viewModel/schedule_state.dart';
import '../model/repository/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    on<LoadSchedules>(_onLoadSchedules);
    on<LoadSchedulesByDay>(_onLoadSchedulesByDay);
    on<LoadScheduledDays>(_onLoadScheduledDays);
    on<AddSchedule>(_onAddSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<DeleteSchedule>(_onDeleteSchedule);
  }

  void _onLoadSchedules(LoadSchedules event, Emitter<ScheduleState> emit) async {
    emit(SchedulesLoading());
    try {
      final schedules = await repository.getAllSchedules();
      emit(SchedulesLoaded(schedules));
    } catch (e) {
      emit(ScheduleError('Failed to load schedules: $e'));
    }
  }


  void _onLoadSchedulesByDay(LoadSchedulesByDay event, Emitter<ScheduleState> emit) async {
    emit(SchedulesLoading());
    try {
      final schedules = await repository.getAllSchedulesByDay(event.day);
      emit(SchedulesLoaded(schedules));
    } catch (e) {
      emit(ScheduleError('Failed to load schedules: $e'));
    }
  }

  void _onLoadScheduledDays(LoadScheduledDays event, Emitter<ScheduleState> emit) async {
    emit(SchedulesLoading());
    try {
      final scheduledDays = await repository.getScheduledDays();
      emit(ScheduledDaysLoaded(scheduledDays));
    } catch (e) {
      emit(ScheduleError('Failed to load schedules: $e'));
    }
  }


  void _onAddSchedule(AddSchedule event, Emitter<ScheduleState> emit) async {
    try {
      await repository.insertSchedule(event.schedule);
      add(LoadSchedules()); // Reload schedules after addition
    } catch (e) {
      emit(ScheduleError('Failed to add schedule: $e'));
    }
  }

  void _onUpdateSchedule(UpdateSchedule event, Emitter<ScheduleState> emit) async {
    try {
      await repository.updateSchedule(event.schedule);
      add(LoadSchedules()); // Reload schedules after update
    } catch (e) {
      emit(ScheduleError('Failed to update schedule: $e'));
    }
  }

  void _onDeleteSchedule(DeleteSchedule event, Emitter<ScheduleState> emit) async {
    try {
      await repository.deleteSchedule(event.id);
      add(LoadSchedules()); // Reload schedules after deletion
    } catch (e) {
      emit(ScheduleError('Failed to delete schedule: $e'));
    }
  }


}