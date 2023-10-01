// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../queries/queries.dart';
import '../queries/streamQueries.dart';
import '../services/getInitialName.dart';

class ChatWidget extends StatefulWidget {
  final customerData;
  const ChatWidget({super.key, required this.customerData});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> _messages = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var streamQuery = StreamQuery();
  var messageData;
  var query = Queries();
  _handleSubmitted({text, sender}) async {
    if (!(text.trim().isEmpty)) {
      var currentConvo = messageData["convo"];
      currentConvo.add({
        "message": text,
        "date": (DateTime.now()).toString(),
        "sender": "driver",
      });
      var messageUpdate = {'convo': currentConvo};
      await query.update("messages", messageData["id"] ?? "", messageUpdate);

      _textController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customerData = widget.customerData;
    return Dialog(
      child: StreamBuilder(
          stream: streamQuery.getMultipleSnapsByData(roots: [
            {"root": "messages"},
          ]),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData) {
              final data = snapshot.data;
              var snapshotList = snapshot.data as List<QuerySnapshot>;
              for (var doc in snapshotList[0].docs) {
                var value = doc.data()! as Map;
                value['id'] = doc.id;
                messageData = value;
                _messages = [];

                value["convo"].forEach((message) {
                  _messages.insert(
                    0,
                    ChatMessage(
                      text: message["message"] ?? "",
                      name: value["name"] ?? "",
                      messageOwner: message["sender"] ?? "",
                    ),
                  );
                });
                // print("see  $messageList");
              }
              return SizedBox(
                height: 400,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            return _messages[index];
                          },
                        ),
                      ),
                      const Divider(height: 1.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                        ),
                        child: _buildTextComposer(),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Loading..."));
            }
          }),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: const IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (value) async {
                  _handleSubmitted(text: "", sender: null);
                },
                decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  await _handleSubmitted(text: _textController.text, sender: "driver");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final name;
  final messageOwner;
  const ChatMessage({super.key, required this.text, required this.name, required this.messageOwner});

  @override
  Widget build(BuildContext context) {
    String userInitialName = getInitailName(name) ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.centerRight,
      child: messageOwner == "driver"
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(text),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: CircleAvatar(
                      child: Text(userInitialName),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    child: Text(userInitialName),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleMedium),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(text),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
