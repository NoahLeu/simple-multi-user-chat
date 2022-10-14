import 'package:flutter/material.dart';
import 'package:chat_client/models/send_message.api.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({super.key});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: const InputDecoration(
              hintText: 'Enter your message',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
        onPressed: () { onPressed(messageController); },
        child: Container(
          height: 40,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Send Message',
            style: TextStyle(color: Colors.white),
          ),
        )),
      ],
    );
  }
}

// define onPressed
void onPressed(TextEditingController messageController) {
  var messageText = messageController.text;
  print('text: $messageText');

  // send message to server
  createMessage(messageText);

  messageController.clear();
}