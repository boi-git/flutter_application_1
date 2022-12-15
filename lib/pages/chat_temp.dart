/*import 'package:flutter_application_1/components/constants/importstaff.dart';

class ChatTemp extends StatefulWidget {
  final String coursename;
  const ChatTemp({super.key, required this.coursename});

  @override
  State<ChatTemp> createState() => _ChatTempState(coursename);
}

class _ChatTempState extends State<ChatTemp> {
  final NavigationService _navigationService = locator<NavigationService>();

  String coursename;
  _ChatTempState(this.coursename);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: GestureDetector(
            onTap: () {
              _navigationService.navigateTo(ChatProfile, arguments: coursename);
            },
            child: StreamBuilder<List<user.Classes>>(
              stream: readClassDetails('CSCI 1301'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;

                  return Column(
                    children: users.map(buildclassMember).toList(),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }
}*/

import 'package:flutter_application_1/components/constants/importstaff.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/backend_components/database_service.dart';
import 'package:flutter_application_1/components/message_tile.dart';
import 'package:flutter_application_1/components/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_menu.dart';

class ChatTemp extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatTemp(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatTemp> createState() => _ChatTempState();
}

class _ChatTempState extends State<ChatTemp> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    //getChatandAdmin();
    super.initState();
  }

  // getChatandAdmin() {
  //   DatabaseService().getChats(widget.groupId).then((val) {
  //     setState(() {
  //       chats = val;
  //     });
  //   });
  //   DatabaseService().getGroupAdmin(widget.groupId).then((val) {
  //     setState(() {
  //       admin = val;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => nextScreen(context, MainMenu),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      String convertedDateTime =
          "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
