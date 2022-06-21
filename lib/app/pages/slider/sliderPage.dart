import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:soket_test/app/models/message.dart';
import 'package:soket_test/app/pages/slider/sliderController.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SliderController controller = Get.find();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          GetBuilder<SliderController>(
              id: 'chats',
              builder: (_) {
                return Expanded(
                  child: ListView(
                    children: _.messages
                        .map(
                          (e) => ItemMessage(
                            message: e,
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: controller.input,
                ),
              ),
              CupertinoButton(
                  child: Text('add'),
                  onPressed: () {
                    MessageModel message = MessageModel(
                        author: 'yo',
                        message: controller.input.text,
                        room: 1,
                        time: 'date');

                    controller.messages.add(message);
                    controller.update(['chats']);

                    controller.input.text = '';
                  })
            ],
          )
        ],
      )),
    );
  }
}

class ItemMessage extends StatelessWidget {
  const ItemMessage({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    RxDouble offset = 0.0.obs;

    return GestureDetector(
      onHorizontalDragUpdate: (detail) {
        offset.value = sqrt(detail.localPosition.dx / 5000);
      },
      onHorizontalDragEnd: (details) {
        if (offset.value > 0.15) {
          print('add');
        } else {
          print('not add');
        }
        offset.value = 0;
      },
      child: Obx(() {
        return FractionalTranslation(
          translation: Offset(offset.value, 0),
          child: Row(
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
                    const SizedBox(
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
      }),
    );
  }
}
