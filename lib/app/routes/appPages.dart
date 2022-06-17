import 'package:get/get.dart';
import 'package:soket_test/app/pages/chat/chatBindings.dart';

import '../pages/chat/chatPage.dart';
part './appRoutes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.Home,
        page: () => const ChatsPage(),
        transition: Transition.fadeIn,
        binding: ChatBixndings()),
  ];
}
