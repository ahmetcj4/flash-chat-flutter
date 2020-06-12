import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  const MessageBubble({
    Key key,
    this.sender,
    this.message,
    this.isMe,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final radiusCircular = Radius.circular(30);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? radiusCircular : Radius.zero,
              topRight: !isMe ? radiusCircular : Radius.zero,
              bottomLeft: radiusCircular,
              bottomRight: radiusCircular,
            ),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
          ),
        ],
      ),
    );
  }
}
