import 'package:f1_telemetry/f1_telemetry.dart';

main() {
  Telemetry telemetry = Telemetry('127.0.0.1', 20777);
  telemetry.streamController.stream.listen((data) {
    print(data);
  });
}
