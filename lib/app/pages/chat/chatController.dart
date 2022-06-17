import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../models/message.dart';

class ChatController extends GetxController {
  late Socket socket;
  final url = 'http://localhost:3001/';
  // final url = 'https://back-real-time-chat.herokuapp.com/';

  ScrollController scrollController = ScrollController();
  RxList messages = [].obs;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  TextEditingController textEditingController = TextEditingController();

  int countPing = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initializeSocket();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        scrolldown();
      }
    });
  }

  RxInt selectedSession = (-1).obs;

  initializeSocket() {
    socket = io(
        url,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect() // for Flutter or Dart VM
            .build());

    // socket.clearListeners();

    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print(socket.connected);

      socket.clearListeners();
      initListeners();
      print("===> has listener ${socket.hasListeners('receive_message')}");
      sendPing();
    });

    countPing = 0;

    // socket.connect(); //connect the Socket.IO Client to the Server
  }

  joinRoom(int room) {
    socket.emit('join_room', room);
    selectedSession.value = room;
    // controllerMessage.getChatByRoom(widget.room);
  }

  initListeners() {
    if (socket.connected) {
      socket.onDisconnect((data) {
        print(data);
      });

      socket.on('receive_message', (data) {
        print('receive');
        print(data);
        try {
          MessageModel message = MessageModel.fromJson(data);
          if (message.author != textEditingController.text) {
            messages.value = [...messages, message];
          }

          update(["chats"]);

          scrolldown();
        } catch (e) {
          print(e);
        }
      });

      socket.onPong((data) {
        countPing = 0;
      });
    }
  }

  sendMessage() {
    MessageModel model = MessageModel(
      message: textController.text,
      author: textEditingController.text,
      room: selectedSession.value,
      time: DateTime.now().toIso8601String(),
    );

    if (socket.connected) {
      socket.emit('send_message', model);

      messages.add(model);
      update(["chats"]);
      scrolldown();
    } else {
      Future.delayed(Duration(milliseconds: 200), () {
        initializeSocket();
        socket.emit('send_message', model);
        messages.add(model);
        update(["chats"]);
        scrolldown();
      });
    }

    textController.text = '';
  }

  sendPing() {
    socket.emit('service_ping');

    if (socket.connected && countPing < 10) {
      Future.delayed(const Duration(seconds: 1), () {
        sendPing();
        countPing++;
      });
    } else {
      socket.close();

      initializeSocket();
    }
  }

  scrolldown() {
    Future.delayed(Duration(milliseconds: 500), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }
}
