import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:soket_test/app/models/message.dart';

class SliderController extends GetxController {
  TextEditingController input = TextEditingController();

  List<MessageModel> messages = [];
}
