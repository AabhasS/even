import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> getConsultations() async {
    String url = "    https://6276b7862f94a1d706066f82.mockapi.io/";
    Uri uri = Uri(
      scheme: 'https',
      host: '6276b7862f94a1d706066f82.mockapi.io',
      path: 'consultation',
    );
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

  Future<bool> postConsultations(Map<String, dynamic> body) async {
    Uri uri = Uri(
      scheme: 'https',
      host: '6276b7862f94a1d706066f82.mockapi.io',
      path: 'consultation',
    );
    var response = await http.post(uri, body: body);

    return (response.statusCode == 201) ? true : false;
  }

  Future<bool> putConsultation(Map<String, dynamic> body) async {
    Uri uri = Uri(
      scheme: 'https',
      host: '6276b7862f94a1d706066f82.mockapi.io',
      path: 'consultation/${body["id"]}',
    );
    var response = await http.put(uri, body: body);
    return (response.statusCode == 200) ? true : false;
  }
}
