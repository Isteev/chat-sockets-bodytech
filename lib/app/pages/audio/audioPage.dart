import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:soket_test/app/pages/audio/audioController.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: GetBuilder<AudioController>(builder: (_) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !_.hasAudio
                  ? RecorderAudio(
                      controller: _,
                    )
                  : PlayerAudio(
                      controller: _,
                    ),
            ],
          ),
        );
      })),
    );
  }
}

class PlayerAudio extends StatelessWidget {
  const PlayerAudio({Key? key, required this.controller}) : super(key: key);

  final AudioController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Slider(
              max: controller.duration.inSeconds.toDouble(),
              value: controller.position.inSeconds.toDouble(),
              onChanged: (val) async {
                final position = Duration(seconds: val.toInt());
                await controller.audioPlayer.seek(position);

                controller.audioPlayer.resume();
                controller.isPlaying = true;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.time(controller.duration),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Text(
                controller.time(controller.position),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (controller.isPlaying) {
                  controller.isPlaying = false;
                  controller.audioPlayer.pause();
                } else {
                  controller.audioPlayer.resume();
                  controller.isPlaying = true;
                }

                controller.update();
              },
              child: Icon(
                controller.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 80,
              )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: controller.currenVelocity == 1.0
                          ? MaterialStateProperty.all(Colors.blueAccent[400])
                          : MaterialStateProperty.all(Colors.grey[400])),
                  onPressed: () {
                    controller.changeVelocity(1);
                  },
                  child: const Text(
                    'X1.0',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: controller.currenVelocity == 1.5
                          ? MaterialStateProperty.all(Colors.blueAccent[400])
                          : MaterialStateProperty.all(Colors.grey[400])),
                  onPressed: () {
                    controller.changeVelocity(1.5);
                  },
                  child: const Text('X1.5',
                      style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: controller.currenVelocity == 2.0
                          ? MaterialStateProperty.all(Colors.blueAccent[400])
                          : MaterialStateProperty.all(Colors.grey[400])),
                  onPressed: () {
                    controller.changeVelocity(2);
                  },
                  child: const Text(
                    'X2.0',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
          CupertinoButton(
              child: Text('new Audio'),
              onPressed: () {
                controller.hasAudio = false;
                controller.audioPlayer.pause();
                controller.position = Duration.zero;
                controller.update();
              })
        ],
      ),
    );
  }
}

class RecorderAudio extends StatelessWidget {
  const RecorderAudio({Key? key, required this.controller}) : super(key: key);

  final AudioController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              if (controller.recorder.isRecording) {
                controller.stop();
              } else {
                controller.record();
              }
            },
            child: Icon(
              controller.recorder.isRecording ? Icons.pause : Icons.mic,
              size: 80,
            )),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<RecordingDisposition>(
            stream: controller.recorder.onProgress,
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              return Text(
                controller.time(duration),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Colors.white),
              );
            }),
      ],
    );
  }
}
