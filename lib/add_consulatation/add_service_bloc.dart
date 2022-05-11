import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:even/consultation.dart';
import 'package:meta/meta.dart';

part 'add_consultation_event.dart';
part 'add_consultation_state.dart';

class AddConsultationBloc
    extends Bloc<AddConsultationEvent, AddConsultationState> {
  AddConsultationBloc() : super(AddConsultationInitial()) {
    emit(SelectServiceScreen(services: serviceTypes));
    on<SelectService>(_mapSelectServiceEventToState);
    on<AddConsultation>((event, emit) {
      emit(AddConsultationScreen(consultation));
    });
  }
  var serviceTypes = [
    "Tele-consultation",
    "Lab Tests",
    "Consultation",
    "Diagnostics",
    "Health Checkup"
  ];
  Consultation consultation = Consultation();

  FutureOr<void> _mapSelectServiceEventToState(
      SelectService event, Emitter<AddConsultationState> emit) {
    emit(SelectServiceScreen(
        services: serviceTypes, selectedService: event.service));
  }
}
