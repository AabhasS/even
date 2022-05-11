import 'dart:ui';

import 'package:even/add_consulatation/add.dart';
import 'package:even/service.dart';
import 'package:even/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'consultation.dart';

const Color lightBlue = Color(0xffB1C7F8);
const Color blue = Color(0xff0055FF);

class Consultations extends StatefulWidget {
  const Consultations({Key? key}) : super(key: key);

  @override
  State<Consultations> createState() => _ConsultationsState();
}

class _ConsultationsState extends State<Consultations>
    with SingleTickerProviderStateMixin {
  double radius = 25;
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<Color> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        setState(() {});
      });

    sizeAnimation = Tween<double>(begin: 50.0, end: window.physicalSize.height)
        .animate(controller);
    colorAnimation =
        Tween<Color>(begin: blue, end: Colors.grey).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffDADFEB),
        title: const Text(
          "My history",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: const Color(0xffDADFEB),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: ApiService().getConsultations(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? Column(
                    children: [
                      AnimatedBuilder(
                        animation: controller.view,
                        builder: (context, _) {
                          return Container(
                            margin: const EdgeInsets.all(5.0),
                            height: radius * 2,
                            width: radius * 2,
                            decoration: BoxDecoration(
                                border: Border.all(color: lightBlue, width: 5),
                                shape: BoxShape.circle,
                                color: blue),
                            child: IconButton(
                                onPressed: () async {
                                  Navigator.of(context)
                                      .push(ServiceSelection());
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: radius,
                                  color: Colors.white,
                                )),
                          );
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Consultation consultation =
                                Consultation.fromJson(snapshot.data![index]);
                            return Row(
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      left: 30,
                                      child: Container(
                                        width: 2.0,
                                        height: 500,
                                        color: lightBlue,
                                      ),
                                    ),
                                    Container(
                                      height: 350.0,
                                      width: 50,
                                      decoration: const BoxDecoration(),
                                      child: Text(
                                        DateFormat('h:mm a d MMMM y').format(
                                            DateTime.parse(consultation.date!)),
                                        style: TextStyle(fontSize: 11),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ConsultationCard(
                                    consultation: consultation,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
