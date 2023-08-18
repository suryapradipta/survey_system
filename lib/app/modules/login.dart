import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:survey_system/app/modules/survey/view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    var url = Uri.parse("http://localhost/survey_system_api/src/login.php");
    var response = await http.post(url, body: {
      "username": username.text,
      "password": password.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      print("login success");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SurveyPage()));
    } else {
      print("login failed");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: username,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Username'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your username";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(onPressed: () {
            login();
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
