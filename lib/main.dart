import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soket_test/app/pages/slider/sliderBindings.dart';
import 'package:soket_test/app/routes/appPages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      initialBinding: SliderBindings(),
      getPages: AppPages.pages,
      initialRoute: Routes.Slider,
    );
  }
}
