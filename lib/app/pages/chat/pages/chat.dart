import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:soket_test/app/models/message.dart';
import 'package:soket_test/app/pages/chat/chatController.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key? key,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ChatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Chat ${controller.selectedSession}'),
          GetBuilder<ChatController>(
              id: 'chats',
              builder: (_) {
                return Expanded(
                  child: ListView(
                    controller: _.scrollController,
                    children: _.messages
                        .map((e) => messageItem(
                              message: e,
                            ))
                        .toList(),
                  ),
                );
              }),

          //
          Row(
            children: [
              Expanded(
                  child: CupertinoTextField(
                controller: controller.textController,
                focusNode: controller.focusNode,
              )),
              CupertinoButton(
                  child: Text('send'),
                  onPressed: () {
                    // controller.sendPing();
                    controller.sendMessage();
                  })
            ],
          )
        ],
      )),
    );
  }
}

class messageItem extends StatelessWidget {
  const messageItem({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        id: "${message.author}${message.room}${message.message}",
        builder: (_) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: message.author == _.textEditingController.text
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent[700],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0))),

                  //
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.2,
                      maxWidth: MediaQuery.of(context).size.width * 0.6),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${message.author}:',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        message.message,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
