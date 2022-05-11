part of 'add_consultation_bloc.dart';

@immutable
abstract class AddConsultationEvent {}

class SelectService extends AddConsultationEvent {
  final String service;

  SelectService(this.service);
}

class AddConsultation extends AddConsultationEvent {}
