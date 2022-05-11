import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:even/consultation.dart';
import 'package:even/service.dart';
import 'package:meta/meta.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddConsultationInitial()) {
    emit(SelectServiceScreen());
    on<SelectService>(_mapSelectServiceEventToState);
    on<AddConsultation>((event, emit) {
      selectedType = event.selectedType;
      emit(AddConsultationScreen(
          consultation: consultation, selected: event.selectedType));
    });
    on<FillValues>((event, emit) {
      emit(AddConsultationScreen(
          consultation: event.consultation, selected: selectedType));
    });
  }
  static const serviceTypes = [
    "Tele-consultation",
    "Lab Tests",
    "Consultation",
    "Diagnostics",
    "Health Checkup"
  ];
  String selectedType = "";
  Consultation consultation = Consultation();

  FutureOr<void> _mapSelectServiceEventToState(
      SelectService event, Emitter<AddServiceState> emit) {
    emit(SelectServiceScreen(selectedService: event.service));
  }

  Future<bool> saveConsultation(Consultation consultation) async {
    bool posted = await ApiService().postConsultations(consultation.toJson());

    return posted;
  }
}
