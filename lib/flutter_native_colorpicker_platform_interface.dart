import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_colorpicker_method_channel.dart';

abstract class FlutterNativeColorpickerPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeColorpickerPlatform.
  FlutterNativeColorpickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeColorpickerPlatform _instance = MethodChannelFlutterNativeColorpicker();

  /// The default instance of [FlutterNativeColorpickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeColorpicker].
  static FlutterNativeColorpickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeColorpickerPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeColorpickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  StreamSubscription<Object?> startListener(Function(Color) onColor) {
    throw UnimplementedError('startListener(Function(Color)) has not been implemented.');
  }

  Future<String?> open(Rect origin) {
    throw UnimplementedError('open(Rect) has not been implemented.');
  }
}
