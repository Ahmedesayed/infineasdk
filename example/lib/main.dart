import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:infineasdk/infineasdk.dart';
import 'package:infineasdk_example/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initCallBackHandler();
  }

  initCallBackHandler(){
    Infineasdk.onEvents((MethodCall call){
        log('method ${call.method} , arguments : ${call.arguments}');
        if(call.method == 'any'); //do any action;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    dynamic platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
       await Infineasdk.setDeveloperKey(ipcDevKey);
       await Infineasdk.connect();
       platformVersion = await Infineasdk.getConnectedDevicesInfo;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InfineaSDK example'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
