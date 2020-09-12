import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mopub_ads/banner.dart';

void main() {
  const MethodChannel channel = MethodChannel('mopub_ads');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MopubAds.platformVersion, '42');
  });
}
