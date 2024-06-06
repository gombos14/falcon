import 'package:bookstore/src/data/falconAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../auth.dart';


class AssistantScreen extends StatefulWidget {
  AssistantScreen({
    super.key,
  });

  @override
  AssistantScreenState createState() => AssistantScreenState();
}

class AssistantScreenState extends State<AssistantScreen> {

  List<Map<String, dynamic>> chats = [
    {
      'message': 'Hello, how can I help you?',
      'sentByMe': false,
    }
  ];
  TextEditingController messageEditingController = TextEditingController();

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sentByMe": true,
        "message": messageEditingController.text
      };
      chats.add(chatMessageMap);

      FalconAPI().getChatResponse(messageEditingController.text,
          FalconAuth.of(context).getUserId.toString()).then((value) {
        Map<String, dynamic> chatMessageMap = {
          "sentByMe": false,
          "message": value
        };
        chats.add(chatMessageMap);
        setState(() {});
      });

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Widget chatMessages() {
    return ListView.builder(padding: EdgeInsets.only(bottom: 70), itemCount: 1, itemBuilder: (context, index) {
      return Column(
          children: [
            for (var chat in chats)
            ChatBubble(
              clipper: ChatBubbleClipper1(type: chat['sentByMe'] == true ?
                BubbleType.sendBubble : BubbleType.receiverBubble),
              alignment: chat['sentByMe'] == true ? Alignment.topRight : Alignment.topLeft,
              margin: EdgeInsets.only(top: 20),
              backGroundColor: chat['sentByMe'] == true ? Colors.blue : Color(0xffE7E7ED),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  chat['message'] as String,
                  style: TextStyle(color: chat['sentByMe'] == true ? Colors.white
                      : Colors.black),
                ),
              ),
            ),
          ]
      );
    });
  }

  Widget chatmsgs() {
    return ListView.builder(itemCount: 1, itemBuilder: (context, index) {
      return Column(
        children: [
          ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 20),
            backGroundColor: Colors.blue,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            backGroundColor: Color(0xffE7E7ED),
            margin: EdgeInsets.only(top: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Falcon Assistant'),
      ),
      body: Container(
        child:
          Stack(
            children: [
              chatMessages(),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.add, color: Colors.white, size: 20, ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: TextField(
                              controller: messageEditingController,
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          FloatingActionButton(
                            onPressed: (){
                              addMessage();
                            },
                            child: Icon(Icons.send,color: Colors.white,size: 18,),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      )
    );
  }
}
