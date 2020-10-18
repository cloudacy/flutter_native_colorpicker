# flutter_native_colorpicker

This package will support all native color pickers shipped with the current OS.

**Actually only works on iOS 14 and above.**

## Usage

1. Simply open the color picker by run the following static method: (origin must be a valid Rect -> see full example for help)

```dart
FlutterNativeColorpicker.open(origin);
```

This just opens the color picker but does not listen for color input.

2. To listen to inputs start a listener:

```dart
listener = FlutterNativeColorpicker.startListener((col) {
  setState(() {
    _color = col;
  });
});
```

**Important**: Please make sure to cancel the listener when disposing the view!

```dart
@override
void dispose() {
  listener.cancel();
  super.dispose();
}
```
