import 'package:get/instance_manager.dart';
import 'package:soket_test/app/pages/audio/audioController.dart';

class AudioBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(() => AudioController());
  }
}
