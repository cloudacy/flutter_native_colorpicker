import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlutterNativeColorpicker {
  static const EventChannel _eventChannel = const EventChannel('flutter_native_colorpicker/event');
  static const MethodChannel _channel = const MethodChannel('flutter_native_colorpicker/method');

  static void startListener(Function(Color) onColor) {
    final stream = _eventChannel.receiveBroadcastStream();

    stream.listen((components) {
      final rgba = List<int>.from(components);

      final color = Color.fromARGB(rgba[3], rgba[0], rgba[1], rgba[2]);
      onColor(color);
    });
  }

  static void open() async {
    await _channel.invokeMethod('openColorpicker');
  }
}
