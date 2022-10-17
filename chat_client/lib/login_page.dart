import 'dart:convert';

import 'package:chat_client/views/home/home.dart';
import 'package:chat_client/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  postData() async {
    var response =
        await http.post(Uri.parse('http://localhost:4000/users/log_in'), body: {
      'email': 'foo',
      'password': 'bar',
    });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    children: [
                      CustomTextFormField.email(
                        label: 'Email',
                        decorationBorderBool: false,
                      ),
                      ElevatedButton(
                        child: const Text('create something'),
                        onPressed: () {
                          setState(() {
                            postData();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField.password(
                        label: 'Password',
                        decorationBorderBool: false,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}


/*Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    Uri.parse('http://localhost:4000/users/log_in'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}*/
