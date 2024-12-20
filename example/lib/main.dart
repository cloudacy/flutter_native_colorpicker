import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_colorpicker/flutter_native_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterNativeColorpickerPlugin = FlutterNativeColorpicker();

  GlobalKey key = GlobalKey();
  Color _color = Colors.black;
  StreamSubscription? listener;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> openColorpicker() async {
    final box = key.currentContext?.findRenderObject();

    if (!(box is RenderBox)) {
      throw StateError('Render object is not a render box');
    }

    final position = box.localToGlobal(Offset.zero);

    listener = _flutterNativeColorpickerPlugin.startListener((col) {
      setState(() {
        _color = col;
      });
    });

    await _flutterNativeColorpickerPlugin.open(position & box.size);
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                key: key,
                onPressed: () {
                  openColorpicker();
                },
                child: Text('Open Colorpicker'),
              ),
              Text(
                'This text gets colored correctly',
                style: TextStyle(color: _color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
