class Consultation {
  String? date;
  String? doctor;
  String? hospital;
  String? hospitalImageUrl;
  String? feedback;
  List<String>? docUrls;

  Consultation(
      {this.date,
      this.doctor,
      this.hospital,
      this.hospitalImageUrl,
      this.docUrls,
      this.feedback});

  Consultation copyWith({
    String? date,
    String? feedback,
    List<String>? docUrls,
  }) {
    return Consultation(
        date: date ?? this.date,
        feedback: feedback ?? this.feedback,
        docUrls: docUrls ?? this.docUrls);
  }

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
        date: json["createdAt"],
        doctor: json["name"],
        hospital: json["hospital"],
        hospitalImageUrl: json["hospitalImageUrl"],
        //docUrls: json["docUrls"],
        feedback: json["feedback"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": date,
      "name": doctor,
      "hospital": hospital,
      "hospitalImageUrl": hospitalImageUrl,
      "feedback": feedback
    };
  }
}
