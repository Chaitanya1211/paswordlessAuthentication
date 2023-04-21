import 'package:app/api/api.dart';
import 'package:app/helper/sharedPrefs.dart';
import 'package:app/screens/register.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../safe/keys.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  Api api = Api();
  Keys key = Keys();
  SharedPrefs shared = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Login'),
                            onPressed: () async {
                              //get secret from server
                              var secretResult = await api
                                  .getSecret(_username.text.toString());
                              String secret = secretResult["encryptedData"];
                              print("Secret received : $secret");
                              //decrypt the secret
                              String res = await key.decryptSecret(secret);
                              print(res);
                              //allow user login
                            },
                          )),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("New User ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text("Register "),
                  ),
                  const Text("Here")
                ],
              )
            ],
          ),
        ));
  }
}
