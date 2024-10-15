import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceId {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    String deviceId = 'Unknown';
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        deviceId = await _getAndroidDeviceId();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        deviceId = await _getIosDeviceId();
      } else {
        log('Unsupported platform');
      }
    } on PlatformException {
      log('Failed to get platform version.');
    }
    return deviceId;
  }

  Future<String> _getAndroidDeviceId() async {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    log('Android Device ID: ${androidInfo.id}');
    return androidInfo.id;
  }

  Future<String> _getIosDeviceId() async {
    final iosInfo = await deviceInfoPlugin.iosInfo;
    log('iOS Device ID: ${iosInfo.identifierForVendor}');
    return iosInfo.identifierForVendor ?? 'Unknown';
  }
}
