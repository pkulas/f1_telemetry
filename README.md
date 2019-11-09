Dart library for fetching telemetry data from F1 2019 game.

[license](https://github.com/pkulas/f1_telemetry/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:f1_telemetry/f1_telemetry.dart';

main() {
  Telemetry telemetry = Telemetry('127.0.0.1', 20777);
  telemetry.streamController.stream.listen((data) {
    print(data);
  });
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/pkulas/f1_telemetry/issues
