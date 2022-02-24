import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopub_flutter/mopub.dart';
import 'package:mopub_flutter/mopub_banner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    try {
      MoPub.init('b195f8dd8ded45fe847ad89ed1d016da', testMode: true).then((_) {
      });
    } on PlatformException {}
  }

  String rewardedResult = "unknown";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoPub SDK Sample'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
              ],
            ),
            MoPubBannerAd(
              adUnitId: 'b195f8dd8ded45fe847ad89ed1d016da',
              bannerSize: BannerSize.STANDARD,
              keepAlive: true,
              listener: (result, dynamic) {
                print('$result');
              },
            ),
            Text(rewardedResult)
          ],
        ),
      ),
    );
  }
}
