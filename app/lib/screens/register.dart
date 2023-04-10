import 'package:flutter/material.dart';
import 'package:app/api/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  Api apiCall = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                    onPressed: () {
                      var response =
                          apiCall.checkAvailability(_username.text.trim());
                      print(response);
                      print("register called");
                    },
                  )),
            ],
          )),
    );
  }
}
