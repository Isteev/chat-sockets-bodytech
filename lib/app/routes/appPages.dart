import 'package:get/get.dart';
import 'package:soket_test/app/pages/audio/audioBinding.dart';
import 'package:soket_test/app/pages/audio/audioPage.dart';
import 'package:soket_test/app/pages/chat/chatBindings.dart';
import 'package:soket_test/app/pages/slider/sliderBindings.dart';
import 'package:soket_test/app/pages/slider/sliderPage.dart';

import '../pages/chat/chatPage.dart';
part './appRoutes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.Home,
        page: () => const ChatsPage(),
        transition: Transition.fadeIn,
        binding: ChatBixndings()),
    GetPage(
        name: Routes.Audio,
        page: () => const AudioPage(),
        transition: Transition.fadeIn,
        binding: AudioBindings()),
    GetPage(
        name: Routes.Slider,
        page: () => const SliderPage(),
        transition: Transition.fadeIn,
        binding: SliderBindings()),
  ];
}
