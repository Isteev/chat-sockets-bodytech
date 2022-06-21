import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioController extends GetxController {
  final recorder = FlutterSoundRecorder();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isRecoredeReady = false;

  bool isPlaying = false;

  bool hasAudio = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  double currenVelocity = 1.0;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'permission reject';
    }

    await recorder.openRecorder();

    isRecoredeReady = true;

    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
      update();
    });

    audioPlayer.onPositionChanged.listen((event) {
      print("========== position $event");
      position = event;
      update();
    });
  }

  Future record() async {
    if (!isRecoredeReady) return;

    await recorder.startRecorder(toFile: 'audio');
    update();
  }

  Future stop() async {
    if (!isRecoredeReady) return;

    final path = await recorder.stopRecorder();

    //final player  = AudioCache(prefix: '/data/user/0/com.example.soket_test/cache/');
    //final url = await player.load('audio');

    audioPlayer.setSourceDeviceFile(path!);
    duration = (await audioPlayer.getDuration())!;
    hasAudio = true;

    update();
  }

  String time(Duration duration) {
    String twoDigits(int n) {
      String fix = '';

      if (n < 10) {
        fix = '0';
      }

      return fix + n.toString().padLeft(2).trim();
    }

    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSegunds = twoDigits(duration.inSeconds.remainder(60));

    return '$twoDigitMinutes:$twoDigitSegunds';
  }

  changeVelocity(double velocity) {
    currenVelocity = velocity;
    audioPlayer.setPlaybackRate(velocity);
    update();
  }
}
