import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_service_bloc.dart';

class ServiceSelectionWidget extends StatelessWidget {
  const ServiceSelectionWidget(
      {Key? key, required this.state, this.isSelected = ""})
      : super(key: key);
  final SelectServiceScreen state;
  final String isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                "Choose type of service",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
          child: Column(
              children: AddServiceBloc.serviceTypes
                  .map<Widget>((service) => ServiceType(
                        label: service,
                        onPressed: () {
                          context
                              .read<AddServiceBloc>()
                              .add(SelectService(service));
                        },
                        isSelected: isSelected,
                      ))
                  .toList()),
        ),
        Center(
          child: Visibility(
            visible: isSelected.isNotEmpty,
            child: TextButton(
                onPressed: () {
                  context
                      .read<AddServiceBloc>()
                      .add(AddConsultation(isSelected));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff0055FF)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 8),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ))),
          ),
        ),
      ],
    );
  }
}

class ServiceType extends StatelessWidget {
  const ServiceType(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.isSelected = ""})
      : super(key: key);
  final String label;
  final Function() onPressed;
  final String isSelected;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Visibility(
              visible: isSelected == label,
              child: const Icon(
                Icons.circle,
                color: Color(0xff0055FF),
                size: 10,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Visibility(
            visible: isSelected == label,
            child: Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.black,
            ),
          ),
        )
      ]),
    );
  }
}
