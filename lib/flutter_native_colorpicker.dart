import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlutterNativeColorpicker {
  static const EventChannel _eventChannel = const EventChannel('flutter_native_colorpicker/event');
  static const MethodChannel _channel = const MethodChannel('flutter_native_colorpicker/method');

  static StreamSubscription<dynamic> startListener(Function(Color) onColor) {
    if (!Platform.isIOS) {
      throw UnsupportedError('Currently only iOS 14.0 and above is supported by this plugin.');
    }

    final stream = _eventChannel.receiveBroadcastStream();

    final subscription = stream.listen((components) {
      final rgba = List<int>.from(components);

      final color = Color.fromARGB(rgba[3], rgba[0], rgba[1], rgba[2]);
      onColor(color);
    });

    return subscription;
  }

  static void open() async {
    if (!Platform.isIOS) {
      throw UnsupportedError('Currently only iOS 14.0 and above is supported by this plugin.');
    }

    await _channel.invokeMethod('openColorpicker');
  }
}
