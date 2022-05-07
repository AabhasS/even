import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Uri uri = Uri(
    scheme: 'https',
    host: '6276b7862f94a1d706066f82.mockapi.io',
    path: 'consultation',
  );
  Future<List<Map<String, dynamic>>> getConsultations() async {
    String url = "    https://6276b7862f94a1d706066f82.mockapi.io/";

    var response = await http.get(uri);
    List<Map<String, dynamic>> l = [];
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      jsonResponse.forEach((element) {
        l.add(element);
      });
    } else {}
    return l;
  }

  postConsultations(Map<String, dynamic> body) async {
    var response = await http.post(uri, body: body);

    print(response.statusCode);
  }
}
