import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  checkAvailability(String username) async {
    Map getapidata = {};
    getapidata['username'] = username;
    // getapidata['publicKey'];
    print("register called");
    var registerData =
        await _performRequest('POST', 'register/check', getapidata);
    print(registerData);
    return registerData;
  }

  _performRequest(String reqType, String endUrl, Map getapidata) async {
    var baseUrl = "http://localhost:3000/";

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(reqType, Uri.parse('$baseUrl$endUrl'));

    request.body = jsonEncode(getapidata);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var datafinal = await response.stream.bytesToString();
      var data = jsonDecode(datafinal);
      return data;
    }
    return {};
  }
}
