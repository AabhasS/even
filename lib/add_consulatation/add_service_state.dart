part of 'add_consultation_bloc.dart';

@immutable
abstract class AddConsultationState {}

class AddConsultationInitial extends AddConsultationState {}

class SelectServiceScreen extends AddConsultationState {
  final String selectedService;
  final List<String> services;

  SelectServiceScreen({this.selectedService = "", required this.services});
}

class AddConsultationScreen extends AddConsultationState {
  final Consultation consultation;

  AddConsultationScreen(this.consultation);
}
