
import 'dart:async';
import 'dart:io';
import 'package:f1_telemetry/src/packets.dart';
import 'package:raw/raw.dart';


class Telemetry {
  StreamController streamController;
  RawDatagramSocket udpSocket;
  bool _paused;
  bool _stopped;
  String _ip_address;
  int _port;

  Telemetry(String ip_address, int port) {
    _paused = false;
    _stopped = false;
    streamController = StreamController(
        onResume: _resume,
        onPause: _pause,
        onListen: _listen,
        onCancel: _cancel);
    _ip_address = ip_address;
    _port = port;
  }

  void _listen() {
    RawDatagramSocket.bind(InternetAddress(_ip_address), _port)
        .then((RawDatagramSocket udpSocket) {
      this.udpSocket = udpSocket;
      udpSocket.listen((RawSocketEvent e) {
        final Datagram dg = udpSocket.receive();
        if (dg != null) {
          if (_stopped) {
            udpSocket.close();
          }

          final RawReader reader = RawReader.withBytes(dg.data);
          final PacketHeader packetHeader = PacketHeader(reader);
          var packetData;
          switch (packetHeader.packetId) {
            // Skip Motion, Event, Car Setups for now, data doesn't seems to be usefull
            case 1:
              {
                packetData = PacketSessionData(reader);
              }
              break;
            case 2:
              {
                packetData = PacketLapData(reader);
              }
              break;
            case 4:
              {
                packetData = PacketParticipantsData(reader);
              }
              break;
            case 6:
              {
                packetData = PacketCarTelemetryData(reader);
              }
              break;
            case 7:
              {
                packetData = PacketCarStatusData(reader);
              }
              break;
            default:
              {}
              break;
          }
          if (packetData != null) {
                streamController.add(packetData);
          }
        }
      });
    });
  }

  void _cancel() {
    udpSocket.close();
  }

  void _resume() {
    _paused = false;
  }

  void _pause() {
    _paused = true;
  }
}
