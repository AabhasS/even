import 'dart:ui';

import 'package:flutter/material.dart';

const Color blue = Color(0xff0055FF);

class AddCons extends StatelessWidget {
  const AddCons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(),
      appBar: AppBar(),
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
        child: StatefulBuilder(builder: (context, setState) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50.0,
              sigmaY: 50,
            ),
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
                        "Choose type of service",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: Column(
                    children: [
                      ServiceType(
                        label: "Tele-Cons",
                        onPressed: () {
                          setState(() {
                            isSelected = "Tele-Cons";
                          });
                        },
                        isSelected: isSelected,
                      ),
                      ServiceType(
                        label: "Lab Test",
                        onPressed: () {
                          setState(() {
                            isSelected = "Lab Test";
                          });
                        },
                        isSelected: isSelected,
                      ),
                      ServiceType(
                        label: "etc",
                        onPressed: () {
                          setState(() {
                            isSelected = "etc";
                          });
                        },
                        isSelected: isSelected,
                      )
                    ],
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: isSelected.isNotEmpty,
                    child: TextButton(
                        onPressed: () {},
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: blue),
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
            ),
          );
        }),
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
              child: Icon(
                Icons.circle,
                color: blue,
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
