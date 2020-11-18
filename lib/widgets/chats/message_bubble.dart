import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;

  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(12),
                    ),
                    color: isMe
                        ? Colors.grey[300]
                        : Theme.of(context).accentColor),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.black : Colors.white),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                            color: isMe ? Colors.black : Colors.white),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: isMe ? null : 120,
              right: isMe ? 120 : null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
            )
          ],
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
