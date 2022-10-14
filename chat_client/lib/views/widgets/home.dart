import 'dart:convert';

import 'package:chat_client/views/widgets/message_display.dart';
import 'package:chat_client/views/widgets/message_form.dart';
import 'package:chat_client/models/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    messages = fetchMessages();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.chat),
            SizedBox(width: 8),
            Text('Chat Client App'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: messages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      /* return ListTile(
                        title: Text(snapshot.data![index].body),
                        subtitle: Text(snapshot.data![index].userEmail),
                      );
                      */
                      return MessageDisplay(
                        message: snapshot.data![index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const MessageForm(),
          ),
        ],
      ),
    );
  }
}

Future<List<Message>> fetchMessages() async {
  final response = await http.get(Uri.parse('http://localhost:4000/api/messages'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as Map<String, dynamic>)['data']['messages']
        .map<Message>((message) => Message.fromJson(message))
        .toList();
  } else {
    throw Exception('Failed to load messages');
  }
}
