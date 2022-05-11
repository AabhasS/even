import 'dart:ui';

import 'package:even/consultation.dart';
import 'package:even/service.dart';
import 'package:even/widgets/card.dart';
import 'package:flutter/material.dart';

class EditFeedback extends ModalRoute<void> {
  final Consultation consultation;
  EditFeedback(this.consultation);
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
    Consultation _consultation = consultation;
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50.0,
            sigmaY: 50,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 8),
                          child: Text(
                            "Dismiss",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ))),
                ConsultationCard(
                  consultation: _consultation,
                  edit: true,
                  onEdit: (value) {
                    _consultation = _consultation.copyWith(feedback: value);
                  },
                ),
                TextButton(
                    onPressed: () async {
                      bool isUpdated = await ApiService()
                          .putConsultation(_consultation.toJson());
                      if (isUpdated) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff0055FF)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 8),
                          child: Text(
                            "Update Feedback",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )))
              ]),
        ),
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
