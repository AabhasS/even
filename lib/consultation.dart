class Consultation {
  String? date;
  String id;
  String? doctor;
  String? hospital;
  String hospitalImageUrl;
  String? feedback;
  List<String>? docUrls;

  Consultation(
      {this.date,
      this.id = "",
      this.doctor,
      this.hospital,
      this.hospitalImageUrl = "assets/images.jpeg",
      this.docUrls,
      this.feedback});

  Consultation copyWith(
      {String? date,
      String? feedback,
      List<String>? docUrls,
      String? hospital,
      String? doctor}) {
    return Consultation(
        id: id ?? this.id,
        date: date ?? this.date,
        feedback: feedback ?? this.feedback,
        docUrls: docUrls ?? this.docUrls,
        hospital: hospital ?? this.hospital,
        doctor: doctor ?? this.doctor);
  }

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
        date: json["createdAt"],
        doctor: json["name"],
        hospital: json["hospital"],
        hospitalImageUrl: json["hospitalImageUrl"],
        id: json["id"],
        feedback: json["feedback"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": date,
      "name": doctor,
      "hospital": hospital,
      "hospitalImageUrl": hospitalImageUrl,
      "feedback": feedback,
      "id": id
    };
  }
}
