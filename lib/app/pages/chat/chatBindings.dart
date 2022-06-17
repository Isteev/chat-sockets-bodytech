import 'package:get/instance_manager.dart';
import 'package:soket_test/app/pages/chat/chatController.dart';

class ChatBixndings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
