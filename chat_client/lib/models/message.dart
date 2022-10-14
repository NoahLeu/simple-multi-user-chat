class Message {
  final String messageID;
  final String body;
  final String sentAt;
  final String userEmail;
  final int userID;

  Message({
    required this.messageID,
    required this.body,
    required this.sentAt,
    required this.userEmail,
    required this.userID,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageID: json['message_id'],
      body: json['body'],
      sentAt: json['sent_at'],
      userEmail: json['user_email'],
      userID: json['user_id'],
    );
  }
}