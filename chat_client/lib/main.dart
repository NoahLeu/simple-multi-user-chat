import 'package:chat_client/views/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Client App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightGreen,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}
