import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'FullScreenVideoPage.dart';
import 'ViewModel/MainPageVM.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late MainPageViewModel vModel = Provider.of<MainPageViewModel>(context);

  @override
  void dispose() {
    // TODO: implement dispose
    vModel.vdoCtr.dispose();
    vModel.editorCtr.disable();
    vModel.keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      vModel
          .initVideoPlayer('https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('多視窗Demo'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black38,
                      child: Center(
                        child: vModel.vState == VideoControllerState.initSuccess
                            ? AspectRatio(
                                aspectRatio: vModel.vdoCtr.value.aspectRatio,
                                child: VideoPlayer(vModel.vdoCtr),
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      // color: Colors.white,
                      child: HtmlEditor(
                        controller: vModel.editorCtr, //required
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: "開始你的紀錄...",
                        ),
                        otherOptions: const OtherOptions(
                          height: 500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[300],
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        // color: Colors.blue.withOpacity(0.3),
                        child: Text("狀態：${vModel.stateStr}"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: vModel.vState != VideoControllerState.init
                            ? IconButton(
                                onPressed: () {
                                  if (vModel.vdoCtr.value.isPlaying) {
                                    vModel.vdoCtr.pause();
                                    vModel.videoDidChangeState(
                                        VideoControllerState.pause);
                                    vModel.updateStatus("影片暫停");
                                  } else {
                                    vModel.vdoCtr.play();
                                    vModel.videoDidChangeState(
                                        VideoControllerState.playing);
                                    vModel.updateStatus("影片播放中");
                                  }
                                },
                                icon: Icon(
                                  vModel.vdoCtr.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 40,
                                ),
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: OutlinedButton(
                          onPressed: () {
                            vModel.setPlaybackSpeed(0.5);
                          },
                          child: const Text(
                            '0.5X',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: OutlinedButton(
                          onPressed: () {
                            vModel.setPlaybackSpeed(1);
                          },
                          child: const Text(
                            '1X',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: OutlinedButton(
                          onPressed: () {
                            vModel.setPlaybackSpeed(1.5);
                          },
                          child: const Text(
                            '1.5X',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: OutlinedButton(
                          onPressed: () {
                            vModel.setPlaybackSpeed(2);
                          },
                          child: const Text(
                            '2X',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.black45.withOpacity(0.5),
                          shape: CircleBorder(),
                        ),
                        width: 80,
                        height: 80,
                        // color: Colors.blue.withOpacity(0.3),
                        child: vModel.vState != VideoControllerState.init
                            ? IconButton(
                                onPressed: () {
                                  toggleFullScreen();
                                },
                                icon: Icon(
                                  Icons.fullscreen,
                                  size: 40,
                                ),
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggleFullScreen() {
    setState(() {
      vModel.isFullScreen = !vModel.isFullScreen;
    });
    if (vModel.isFullScreen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FullScreenVideoPlayer(controller: vModel.vdoCtr),
        ),
      ).then((_) {
        // 當返回主頁面時，重新設置為非全螢幕模式
        // setState(() {
        //   _isFullScreen = false;
        // });
        vModel.isFullScreen = false;
      });
    }
  }
}
