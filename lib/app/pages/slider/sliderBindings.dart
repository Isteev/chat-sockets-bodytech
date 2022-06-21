import 'package:get/get.dart';
import 'package:soket_test/app/pages/slider/sliderController.dart';

class SliderBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SliderController>(() => SliderController());
  }
}
