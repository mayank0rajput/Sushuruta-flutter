import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClient {
    static Future<dynamic> fetchData(String req) async {
      var data;
      var headers = { 'Content-Type': 'application/json' };
      // const url = dotenv.env
      var request = http.Request('POST', Uri.parse(' '));
      request.body = json.encode({"userPrompt": req });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resBody = await response.stream.bytesToString();
        final reply = jsonDecode(resBody)['response'];
        final status = jsonDecode(resBody)['status'];
        data = [reply,status];
        return data;
      }
      else {
      print(response.reasonPhrase);
      return null;
      }
    }
}