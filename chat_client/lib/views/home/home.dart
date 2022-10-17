import 'dart:convert';

import 'package:chat_client/views/home/widgets/message_display.dart';
import 'package:chat_client/views/home/widgets/message_form.dart';
import 'package:chat_client/models/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_client/login_page.dart';

import 'package:phoenix_wings/phoenix_wings.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final socket = PhoenixSocket("ws://localhost:4000/socket/websocket");

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Message> messages;
  late PhoenixChannel _channel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => updateMessages());
    _connectSocket();

    setState(() {
      messages = [];
    });
  }

  void updateMessages() async {
    var new_messages = await fetchMessages();

    setState(() {
      messages = new_messages;
    });
  }

  Future<void> _connectSocket() async {
    await widget.socket.connect();

    _channel = widget.socket.channel("room:message_updates");
    _channel.on("new_msg", (payload, ref, joinRef) {
      updateMessages();
    });
    _channel.on("delete_msg", (payload, ref, joinRef) {
      updateMessages();
    });

    _channel.join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat),
            const SizedBox(width: 8),
            const Text('Chat Client App'),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              return MessageDisplay(
                message: messages[messages.length - index - 1],
              );
            },
          )),
          Container(
            padding: const EdgeInsets.all(8),
            child: MessageForm(onMessageSent: updateMessages),
          ),
        ],
      ),
    );
  }
}

Future<List<Message>> fetchMessages() async {
  final response =
      await http.get(Uri.parse('http://localhost:4000/api/messages'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as Map<String, dynamic>)['data']
            ['messages']
        .map<Message>((message) => Message.fromJson(message))
        .toList();
  } else {
    throw Exception('Failed to load messages');
  }
}
