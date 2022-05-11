part of 'add_service_bloc.dart';

@immutable
abstract class AddServiceState {}

class AddConsultationInitial extends AddServiceState {}

class SelectServiceScreen extends AddServiceState {
  final String selectedService;

  SelectServiceScreen({this.selectedService = ""});
}

class AddConsultationScreen extends AddServiceState {
  final String selected;
  final Consultation consultation;

  AddConsultationScreen({required this.consultation, this.selected = ""});
}
