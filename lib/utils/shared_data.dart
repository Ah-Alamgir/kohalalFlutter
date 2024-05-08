import 'package:flutter/services.dart';

class SharedData {
  static const platform = MethodChannel('app.channel.shared.data');

  static Future<String?> getSharedText() async {
    final String? sharedText = await platform.invokeMethod('getSharedText');
    return sharedText;
  }

  static Future<String?> getSharedImageUri() async {
    final String? sharedImageUri =
        await platform.invokeMethod('getSharedImageUri');
    return sharedImageUri;
  }
}
