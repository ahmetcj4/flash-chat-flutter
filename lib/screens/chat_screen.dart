import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/message_buble.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = Firestore.instance;
  final messageTextController = TextEditingController();
  FirebaseUser user;
  String message;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    try {
      user = await _auth.currentUser();
      print(user.email);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _store.collection('messages').snapshots(),
                builder: (c, s) {
                  if (!s.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      children: s.data.documents.reversed.map(
                        (message) {
                          var sender = message.data['sender'];
                          return MessageBubble(
                            sender: sender,
                            message: message.data['message'],
                            isMe: sender == user.email,
                          );
                        },
                      ).toList(),
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) => message = value,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _store.collection('messages').add(
                        {
                          'sender': user.email,
                          'message': message,
                        },
                      );
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
