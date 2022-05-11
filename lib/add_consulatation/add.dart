import 'dart:ui';

import 'package:even/add_consulatation/add_service_bloc.dart';
import 'package:even/add_consulatation/service_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const Color blue = Color(0xff0055FF);

class AddConsultationWidget extends StatelessWidget {
  const AddConsultationWidget({Key? key, required this.state})
      : super(key: key);
  final AddConsultationScreen state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 20,
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Enter Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: AddServiceBloc.serviceTypes
                  .map((service) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          service,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              backgroundColor: state.selected == service
                                  ? Colors.yellow
                                  : Colors.transparent),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Column(
            children: [
              TextField(
                onChanged: (val) {
                  ///TO DO Add a suggestive dropdown for selection
                  context.read<AddServiceBloc>().add(
                      FillValues(state.consultation.copyWith(hospital: val)));
                },
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: "Hospital Name"),
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Consultation Details".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              TextField(
                onChanged: (val) {
                  context.read<AddServiceBloc>().add(
                      FillValues(state.consultation.copyWith(doctor: val)));
                },
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: "Doctor's Name"),
              ),
              Row(
                children: [
                  Visibility(
                      visible: state.consultation.date?.isNotEmpty ?? false,
                      child: Expanded(
                        child: TextField(
                          enabled: false,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: TextEditingController(
                            text: DateFormat('MMMM d, yy').format(
                                DateTime.parse(state.consultation.date ??
                                    DateTime.now().toIso8601String())),
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none, labelText: "Date"),
                        ),
                      )),
                  TextButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));
                        context.read<AddServiceBloc>().add(FillValues(state
                            .consultation
                            .copyWith(date: date?.toIso8601String())));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: blue.withOpacity(0.2)),
                        child: Text(
                          state.consultation.date?.isNotEmpty ?? false
                              ? "Change"
                              : "Choose Date & Time",
                          style: TextStyle(
                              color: blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Container(
              height: 1,
              color: Colors.black38,
            ),
          ),
          TextField(
            onChanged: (val) {
              context
                  .read<AddServiceBloc>()
                  .add(FillValues(state.consultation.copyWith(feedback: val)));
            },
            decoration: InputDecoration(
                border: InputBorder.none, labelText: "Feedback"),
          ),
          Center(
            child: Visibility(
              visible: true,
              child: TextButton(
                  onPressed: () async {
                    bool isSaved = await context
                        .read<AddServiceBloc>()
                        .saveConsultation(state.consultation);

                    if (isSaved) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30), color: blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 8),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceSelection extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  String isSelected = "";
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: BlocProvider<AddServiceBloc>(
            create: (context) => AddServiceBloc(),
            child: BlocBuilder<AddServiceBloc, AddServiceState>(
                builder: (context, state) {
              Widget _widget = Container();

              if (state is SelectServiceScreen) {
                isSelected = state.selectedService;
                _widget = ServiceSelectionWidget(
                  state: state,
                  isSelected: isSelected,
                );
              }

              if (state is AddConsultationScreen) {
                _widget = AddConsultationWidget(
                  state: state,
                );
              }

              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 50.0,
                  sigmaY: 50,
                ),
                child: _widget,
              );
            })),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
