import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ntp/ntp.dart';

class SynchronizedTime {
  SynchronizedTime._();

  static Duration? _timeDifference;

  static Future<void> initialize() async {
    if (kIsWeb) {
      // Handle web-specific initialization
      print("Web environment detected. Skipping NTP initialization.");
    } else {
      // Non-web environment
      final DateTime NetworkTime = await NTP.now();
      final DateTime DeviceTime = DateTime.now();
      _timeDifference = NetworkTime.difference(DeviceTime);
    }
  }

  static DateTime now() {
    return DateTime.now().add(_timeDifference ?? Duration.zero);
  }
}
