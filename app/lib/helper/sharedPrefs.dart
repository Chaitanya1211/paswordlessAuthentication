// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  setPrivateKey(String privateKey) async {
    // getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
  }

  setPublicKey(String publicKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('publicKey', publicKey);
  }

  getPrivateKey() async {
    // getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString('privateKey');
    if (res == null) {
      return null;
    } else {
      return res;
    }
  }

  getPublicKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString('publicKey');
    if (res == null) {
      return null;
    } else {
      return res;
    }
  }
}
