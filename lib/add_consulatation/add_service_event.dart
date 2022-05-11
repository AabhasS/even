part of 'add_service_bloc.dart';

@immutable
abstract class AddServiceEvent {}

class SelectService extends AddServiceEvent {
  final String service;

  SelectService(this.service);
}

class AddConsultation extends AddServiceEvent {
  final String selectedType;

  AddConsultation(this.selectedType);
}

class FillValues extends AddServiceEvent {
  final Consultation consultation;

  FillValues(this.consultation);
}
