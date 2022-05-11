import 'dart:ui';

import 'package:even/edit_feedBack.dart';
import 'package:flutter/material.dart';

import '../consultation.dart';

class ConsultationCard extends StatelessWidget {
  const ConsultationCard(
      {Key? key, required this.consultation, this.edit = false, this.onEdit})
      : super(key: key);
  final Consultation consultation;
  final bool edit;
  final Function(String)? onEdit;

  @override
  Widget build(BuildContext context) {
    Consultation _consultation = consultation;
    TextEditingController _controller =
        TextEditingController(text: _consultation.feedback);
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
                  const Text(
                    "CONSULTATION",
                    style:
                        TextStyle(backgroundColor: Colors.yellow, fontSize: 10),
                  ),
                  Image.asset(
                    _consultation.hospitalImageUrl,
                    scale: 3,
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                _consultation.doctor ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_consultation.hospital ?? ""),
            ),
            ListTile(
              title: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff0055FF)),
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
                            color: Color(0xff0055FF)),
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
              color: Color(0xffF1F4F9),
              child: ListTile(
                trailing: TextButton(
                    onPressed: () async {
                      await Navigator.push(context, EditFeedback(consultation));
                    },
                    child:
                        Visibility(visible: !edit, child: const Text("Edit"))),
                title: const Text(
                  "Feedback",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                subtitle: edit
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controller,
                          onChanged: (val) {
                            onEdit!(val);
                          },
                        ),
                      )
                    : Text(_consultation.feedback ??
                        "Every interaction ith the hospital was great"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
