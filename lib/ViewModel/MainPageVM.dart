import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:video_player/video_player.dart';
import 'package:html_editor_enhanced/html_editor.dart';

enum VideoControllerState {
  init,
  initSuccess,
  playing,
  pause,
  complete,
  error,
}

class MainPageViewModel extends ChangeNotifier {


  late VideoPlayerController vdoCtr;
  VideoControllerState vState = VideoControllerState.init;
  bool isFullScreen = false;
  HtmlEditorController editorCtr = HtmlEditorController();
  String stateStr = "影片初始化中";
  String lastStsStr = "影片初始化中";
  late StreamSubscription<bool> keyboardSubscription;



  void updateStatus(String str){
    if (!str.contains('文字輸入中')) {
      lastStsStr = str;
    }
    stateStr = str;
    notifyListeners();
  }

  void initVideoPlayer(String url) {
    vdoCtr = VideoPlayerController.networkUrl(Uri.parse(url));
    vdoCtr.initialize().then((value) {
      // print("Video did finish init: ${vdoCtr.value}");
      vState = VideoControllerState.initSuccess;
      notifyListeners();
      updateStatus('影片初始化成功');
    });

    // editorCtr.addNotification((html, notificationType){});
    var keyboardVisibilityController = KeyboardVisibilityController();


    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (visible){
        updateStatus("文字輸入中");
      } else {
        updateStatus(lastStsStr);
      }
    });

  }

  void videoDidChangeState(VideoControllerState state){
    // vState = state;
    notifyListeners();
    // updateStatus();
  }

  void setPlaybackSpeed(double speed) {
    vdoCtr.setPlaybackSpeed(speed);
    notifyListeners();
  }

}