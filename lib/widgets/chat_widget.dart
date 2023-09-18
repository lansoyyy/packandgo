import 'package:flutter/material.dart';

import '../services/getInitialName.dart';

class ChatWidget extends StatefulWidget {
  final customerData;
  const ChatWidget({super.key, required this.customerData});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  _handleSubmitted({text, sender}) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.insert(
          0,
          ChatMessage(
            text: text,
            name: widget.customerData["name"],
            messageOwner: widget.customerData["message-list"]["sender"] ?? "driver",
          ));
    });
    _textController.clear();
  }

  @override
  void initState() {
    for (var message in widget.customerData["message-list"]) {
      print("see emessage $message");
      // _handleSubmitted(text: message["message"] ?? "", sender: message["sender"]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customerData = widget.customerData;
    print("customer data $customerData");
    return Dialog(
      child: SizedBox(
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
      ),
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
                onSubmitted: _handleSubmitted(text: "", sender: null),
                decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(text: _textController.text, sender: "driver"),
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
