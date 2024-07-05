import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app_flutter/viewModel/schedule_event.dart';
import 'package:schedule_app_flutter/viewModel/schedule_state.dart';
import '../model/data/schedule.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState>{
  ScheduleBloc(): super(ScheduleInitial()){
    on<LoadSchedules>(_onLoadSchedules);
    on<AddSchedule>(_onAddSchedule);
  }

  void _onLoadSchedules(LoadSchedules event, Emitter<ScheduleState> emit) {
    emit(ScheduleLoading());
    try{
      //fetch schedule from db
      final schedules = <Schedule>[];
      emit(ScheduleLoaded(schedules));
    } catch (e){
      emit(ScheduleError(e.toString()));
    }
  }

  void _onAddSchedule(AddSchedule event, Emitter<ScheduleState> emit) {
    if (state is ScheduleLoaded){
      final currentState = state as ScheduleLoaded;
      final updateSchedules = List<Schedule>.from(currentState.schedules)
        ..add(event.schedule);
      emit(ScheduleLoaded(updateSchedules));
    }
  }
}