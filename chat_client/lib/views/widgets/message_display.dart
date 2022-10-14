import 'package:flutter/material.dart';
import 'package:chat_client/models/message.dart';
import 'package:intl/intl.dart';

class MessageDisplay extends StatefulWidget {
  const MessageDisplay({super.key, required this.message});

  final Message message;

  @override
  State<MessageDisplay> createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message.userEmail,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.message.body),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              DateFormat('dd.MM.yyyy HH:mm')
                  .format(DateTime.parse(widget.message.sentAt))
                  .toString(),
              style: const TextStyle(
                color: Colors.grey,
              ), 
            )
          ],
        ));
  }
}
