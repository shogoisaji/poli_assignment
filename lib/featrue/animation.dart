import 'package:rive/rive.dart';

enum SendAnimationTypeEnum {
  init,
  send,
}

class SendAnimation {
  SendAnimationTypeEnum type = SendAnimationTypeEnum.init;
  SimpleAnimation controller = SimpleAnimation('init');

  void changeAnimation() {
    switch (type) {
      case SendAnimationTypeEnum.init:
        type = SendAnimationTypeEnum.send;
        controller = SimpleAnimation('send');
        return;
      case SendAnimationTypeEnum.send:
        type = SendAnimationTypeEnum.init;
        controller = SimpleAnimation('init');
        return;
      default:
        return;
    }
  }

  getController() {
    return controller;
  }
}
