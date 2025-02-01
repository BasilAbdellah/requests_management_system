import 'package:ntp/ntp.dart';

class SynchronizedTime {
  SynchronizedTime._();

  static Duration? _timeDifference;

  static Future<void> initialize() async {
    final DateTime NetworkTime = await NTP.now();

    final DateTime DeviceTime = DateTime.now();

    _timeDifference = NetworkTime.difference(DeviceTime);
  }

  static DateTime now() {
    return DateTime.now().add(_timeDifference ?? Duration.zero);
  }
}
