import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:soket_test/app/pages/chat/chatController.dart';

class Sessions extends StatelessWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChatController controller = Get.find();

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.joinRoom(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                  color: Colors.grey[400],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Session 1',
                  style: TextStyle(
                      color: Colors.blueAccent[600],
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.05),
                ),
              ),
            ),
            CupertinoTextField(
              controller: controller.textEditingController,
            )
          ],
        ),
      )),
    );
  }
}
