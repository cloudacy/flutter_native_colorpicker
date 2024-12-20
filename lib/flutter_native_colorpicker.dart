import 'dart:async';

import 'package:flutter/widgets.dart';

import 'flutter_native_colorpicker_platform_interface.dart';

class FlutterNativeColorpicker {
  StreamSubscription<Object?> startListener(Function(Color) onColor) {
    return FlutterNativeColorpickerPlatform.instance.startListener(onColor);
  }

  Future<String?> open(Rect origin) {
    return FlutterNativeColorpickerPlatform.instance.open(origin);
  }
}
