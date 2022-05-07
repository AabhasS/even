import 'package:even/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'consultation.dart';

Color lightBlue = Color(0xffB1C7F8);
Color blue = Color(0xff0055FF);

class Consultations extends StatefulWidget {
  Consultations({Key? key}) : super(key: key);

  @override
  State<Consultations> createState() => _ConsultationsState();
}

class _ConsultationsState extends State<Consultations>
    with SingleTickerProviderStateMixin {
  double radius = 25;
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..addListener(() {
            //setState(() {});
          });

    sizeAnimation = Tween<double>(begin: 50.0, end: 1000.0).animate(controller);
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
        backgroundColor: Color(0xffDADFEB),
        title: Text(
          "My history",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xffDADFEB),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: ApiService().getConsultations(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? ListView.builder(
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Stack(
                          children: <Widget>[
                            Positioned(
                              top: 50.0,
                              bottom: 0.0,
                              left: radius,
                              child: Container(
                                width: 2.0,
                                color: lightBlue,
                              ),
                            ),
                            Container(
                                height: 70,
                                child: Center(
                                    child: Text(
                                  "Add Consultation",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: blue),
                                ))),
                            Positioned(
                              left: 0,
                              child: AnimatedBuilder(
                                animation: controller.view,
                                builder: (context, _) {
                                  return Container(
                                    margin: const EdgeInsets.all(5.0),
                                    height: radius * 2,
                                    width: radius * 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightBlue, width: 5),
                                        shape: BoxShape.circle,
                                        color: blue),
                                    child: IconButton(
                                        onPressed: () async {
                                          controller.forward();
                                          await ApiService().postConsultations(
                                            {
                                              "createdAt":
                                                  "2022-05-07T00:45:56.075Z",
                                              "name": "Mr. Aabhas Singhal",
                                              "avatar":
                                                  "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/963.jpg",
                                              "id": "1",
                                              "date":
                                                  "2022-05-07T17:47:25.443Z",
                                              "doctor": "Dr. Jordan Henderson",
                                              "hospital":
                                                  "Aster RV Multi Speciality Hospital",
                                              "hospitalImageUrl":
                                                  "assets/images.jpeg",
                                              "feedback":
                                                  "Every interaction was good",
                                              "docUrls": ""
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: radius,
                                          color: Colors.white,
                                        )),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      Consultation consultation =
                          Consultation.fromJson(snapshot.data![index - 1]);
                      return Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: ConsultationCard(
                                consultation: consultation,
                              )),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: radius,
                            child: Container(
                              width: 2.0,
                              color: lightBlue,
                            ),
                          ),
                          Positioned(
                            top: 25.0,
                            left: radius - 20,
                            child: Container(
                              height: 40.0,
                              width: 50,
                              decoration: const BoxDecoration(),
                              child: Text(
                                DateFormat('h:mm a d MMMM y')
                                    .format(DateTime.parse(consultation.date!)),
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({Key? key, required this.consultation})
      : super(key: key);
  final Consultation consultation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CONSULTATION",
                    style:
                        TextStyle(backgroundColor: Colors.yellow, fontSize: 10),
                  ),
                  Image.asset(
                    consultation.hospitalImageUrl ?? "",
                    scale: 3,
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                consultation.doctor ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(consultation.hospital ?? ""),
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: blue),
                  )
                ],
              ),
              subtitle: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: blue),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              "UPLOAD DOCS",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.withOpacity(0.2)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              "DELETE",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(0xffF1F4F9),
              child: ListTile(
                trailing: Text("Edit"),
                title: Text(
                  "Feedback",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                subtitle: Text(consultation.feedback ??
                    "Every interaction ith the hospital was great"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
