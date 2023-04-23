import 'dart:convert';

import 'package:app/helper/sharedPrefs.dart';
import 'package:http/http.dart' as http;

class Api {
  SharedPrefs shared = SharedPrefs();

  checkAvailability(String username) async {
    Map getapidata = {};
    getapidata['username'] = username;
    var registerData =
        await _performRequest('POST', 'register/check', getapidata);
    return registerData["message"];
  }

  registerUser(String username) async {
    Map getapidata = {};
    getapidata['username'] = username;
    var registerResult =
        await _performRequest('POST', 'register/new', getapidata);
    // print(registerResult);
    return registerResult;
  }

  login(String username, String encodedData) async {
    Map getapidata = {};
    getapidata['username'] = username;
    getapidata['encryptedData'] = encodedData;

    var result = await _performRequest('GET', 'login', getapidata);

    print(result);
  }
  // getSecret(String username) async {
  //   Map getapidata = {};
  //   getapidata['username'] = username;
  //   var secretResult = await _performRequest('GET', 'login/secret', getapidata);
  //   return secretResult;
  // }

  // verifySecret(String username, String privateKey) async {
  //   print("Verify secret called");
  //   Map getapidata = {};

  //   getapidata['username'] = username;
  //   getapidata['privateKey'] = privateKey;

  //   var res = await _performRequest('GET', 'login/verify', getapidata);
  //   print(res);
  //   return res;
  // }

  _performRequest(String reqType, String endUrl, Map getapidata) async {
    var baseUrl = "http://43.205.216.163/";

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(reqType, Uri.parse('$baseUrl$endUrl'));

    request.body = jsonEncode(getapidata);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Response recieved");
      var datafinal = await response.stream.bytesToString();
      var data = jsonDecode(datafinal);
      return data;
    }
    print("Response not recieved");
    return {};
  }
}
