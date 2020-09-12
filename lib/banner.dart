library adcolony;

import 'package:flutter/services.dart';

enum MoPubAdListener {
  onRequestFilled,
  onRequestNotFilled,
  onReward,
  onOpened,
  onClosed,
  onIAPEvent,
  onExpiring,
  onLeftApplication,
  onClicked
}

typedef MoPubAdListener(MoPubAdListener listener);

class AdColony {
  static final MethodChannel channel = MethodChannel('AdColony');
  static final Map<String, MoPubAdListener> MoPubAdListener = {
    'onRequestFilled': MoPubAdListener.onRequestFilled,
    'onRequestNotFilled': MoPubAdListener.onRequestNotFilled,
    'onReward': MoPubAdListener.onReward,
    'onOpened': MoPubAdListener.onOpened,
    'onClosed': MoPubAdListener.onClosed,
    'onIAPEvent': MoPubAdListener.onIAPEvent,
    'onLeftApplication': MoPubAdListener.onLeftApplication,
    'onClicked': MoPubAdListener.onClicked,
  };

  static Future<void> init(AdColonyOptions options) async {
    try {
      await channel.invokeMethod('Init', options.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> request(String zone, AdColonyListener listener) async {
    try {
      channel.setMethodCallHandler(
          (MethodCall call) async => handleMethod(call, listener));
      await channel.invokeMethod('Request', {'Id': zone});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> show() async {
    try {
      await channel.invokeMethod('Show');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> handleMethod(
      MethodCall call, AdColonyListener listener) async {
    listener(MoPubAdListener[call.method]);
  }
}

class AdColonyOptions {
  final String id;
  final String gdpr;
  final List<String> zones;

  AdColonyOptions(this.id, this.gdpr, this.zones);

  Map<String, dynamic> toJson() =>
      {'Id': this.id, 'Gdpr': this.gdpr, 'Zones': this.zones};
}
