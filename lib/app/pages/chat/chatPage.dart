import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:soket_test/app/pages/chat/chatController.dart';
import 'package:soket_test/app/pages/chat/pages/chat.dart';
import 'package:soket_test/app/pages/chat/pages/sessiones.dart';

class ChatsPage extends GetView<ChatController> {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.selectedSession.value < 0
          ? const Sessions()
          : const Chat();
    });
  }
}
