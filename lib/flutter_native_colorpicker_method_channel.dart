import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_colorpicker_platform_interface.dart';

/// An implementation of [FlutterNativeColorpickerPlatform] that uses method channels.
class MethodChannelFlutterNativeColorpicker extends FlutterNativeColorpickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_colorpicker/method');

  /// The event channel used to interact with the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('flutter_native_colorpicker/event');

  @override
  StreamSubscription<Object?> startListener(Function(Color) onColor) {
    if (!Platform.isIOS) {
      throw UnsupportedError('Currently only iOS 14.0 and above is supported by this plugin.');
    }

    final stream = eventChannel.receiveBroadcastStream();

    final subscription = stream.listen((components) {
      final rgba = List<int>.from(components);

      final color = Color.fromARGB(rgba[3], rgba[0], rgba[1], rgba[2]);
      onColor(color);
    });

    return subscription;
  }

  @override
  Future<String?> open(Rect origin) async {
    final version = await methodChannel.invokeMethod<String>(
      'openColorpicker',
      {
        'origin': {
          'x': origin.left,
          'y': origin.top,
          'width': origin.width,
          'height': origin.height,
        },
      },
    );
    return version;
  }
}
