import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_native_colorpicker/flutter_native_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey key = GlobalKey();
  Color _color = Colors.black;
  StreamSubscription listener;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> openColorpicker() async {
    final RenderBox box = key.currentContext.findRenderObject();
    final position = box.localToGlobal(Offset.zero);

    FlutterNativeColorpicker.open(position & box.size);
    listener = FlutterNativeColorpicker.startListener((col) {
      setState(() {
        _color = col;
      });
    });
  }

  @override
  void dispose() {
    listener.cancel();
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
