import 'dart:convert';

import 'package:app/helper/alert.dart';
import 'package:app/helper/sharedPrefs.dart';
import 'package:app/safe/keys.dart';
import 'package:flutter/material.dart';
import 'package:app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  Api apiCall = Api();
  Alert alert = Alert();
  Keys key = Keys();
  List<String> keys = [];
  SharedPrefs shared = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter Username',
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      var response = await apiCall
                          .checkAvailability(_username.text.trim());
                      print(response);
                      if (response == "user exists") {
                        alert.showMyDialog(context, "Username already exixts",
                            "The username already exists. Please try again with different username");
                      } else {
                        //genrate keys
                        keys = key.generateRSAKeyPair(2048);
                        var publicKey = keys[0];
                        var privateKey = keys[1];
                        //store private key in local
                        // getInstance();
                        shared.setPrivateKey(privateKey);
                        // String res = await shared.getPrivateKey();
                        // print("Private key is :" + res);
                        var registerResponse = await apiCall.registerUser(
                            _username.text.trim(), publicKey);

                        print(registerResponse);
                      }
                    },
                  )),
            ],
          )),
    );
  }
}
