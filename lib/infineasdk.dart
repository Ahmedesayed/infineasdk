import 'dart:async';

import 'package:flutter/services.dart';

class Infineasdk {
     // SCAN MODES
     static const  MODE_SINGLE_SCAN = 0;
     static const  MODE_MULTI_SCAN = 1;
     static const  MODE_MOTION_DETECT = 2;
     static const  MODE_SINGLE_SCAN_RELEASE = 3;
     static const  MODE_MULTI_SCAN_NO_DUPLICATES = 4;
     // CONNECTION STATES
     static const  CONN_DISCONNECTED = 0;
     static const  CONN_CONNECTING= 1;
     static const  CONN_CONNECTED= 2;
     // UPDATE PHASES
     static const  UPDATE_COMPLETING = 4;
     static const  UPDATE_FINISH = 3;
     static const  UPDATE_WRITE = 2;
     static const  UPDATE_ERASE = 1;
     static const  UPDATE_INIT = 0;

  static const MethodChannel _channel =
      const MethodChannel('infineasdk');

  static Future<String> get platformVersion async {
    final String result = await _channel.invokeMethod('getPlatformVersion');
    return result;
  }

  static Future<String> get sdkVersion async {
    final String result = await _channel.invokeMethod('sdkVersion');
    return result;
  }
  static Future<String> get getConnectedDeviceInfo async {
    final String result = await _channel.invokeMethod('getConnectedDeviceInfo');
    return result;
  }
  static Future<String> get getConnectedDevicesInfo async {
    final String result = await _channel.invokeMethod('getConnectedDevicesInfo');
    return result;
  }
  static Future<String> get getPassThroughSync async {
    final String result = await _channel.invokeMethod('getPassThroughSync');
    return result;
  }
  static Future<String> get getUSBChargeCurrent async {
    final String result = await _channel.invokeMethod('getUSBChargeCurrent');
    return result;
  }
  static Future<String> get getBatteryInfo async {
    final String result = await _channel.invokeMethod('getBatteryInfo');
    return result;
  }
  static Future<String> get rfInit async {
    final String result = await _channel.invokeMethod('rfInit');
    return result;
  }
  static Future<String> get rfClose async {
    final String result = await _channel.invokeMethod('rfClose');
    return result;
  }
  static Future<String> get barcodeGetScanButtonMode async {
    final String result = await _channel.invokeMethod('barcodeGetScanButtonMode');
    return result;
  }
  static Future<String> get barcodeGetScanMode async {
    final String result = await _channel.invokeMethod('barcodeGetScanMode');
    return result;
  }
  static Future<String> get barcodeStartScan async {
    final String result = await _channel.invokeMethod('barcodeStartScan');
    return result;
  }
  static Future<String> get barcodeStopScan async {
    final String result = await _channel.invokeMethod('barcodeStopScan');
    return result;
  }
  static Future<String> get getFirmwareFileInformation async {
    final String result = await _channel.invokeMethod('getFirmwareFileInformation');
    return result;
  }
  static Future<String> get emsrIsTampered async {
    final String result = await _channel.invokeMethod('emsrIsTampered');
    return result;
  }
  static Future<String> emsrGetKeyVersion(String keyId) async {
    final String result = await _channel.invokeMethod('emsrGetKeyVersion',[keyId]);
    return result;
  }
  static Future<String> get emsrGetDeviceInfo async {
    final String result = await _channel.invokeMethod('emsrGetDeviceInfo');
    return result;
  }
  static Future<String> setPassThroughSync(String value) async {
    final String result = await _channel.invokeMethod('setPassThroughSync',[value]);
    return result;
  }
  static Future<String> setUSBChargeCurrent(int value) async {  // Must be one of 500, 1000, 2100, 2400
    final String result = await _channel.invokeMethod('setUSBChargeCurrent',[value]);
    return result;
  }
  static Future<String> setAutoOffWhenIdle(int timeIdle, int timeDisconnected) async {
    final String result = await _channel.invokeMethod('setAutoOffWhenIdle',[timeIdle, timeDisconnected]);
    return result;
  }
  static Future<String> barcodeSetScanButtonMode(bool value) async {
    final String result = await _channel.invokeMethod('barcodeSetScanButtonMode',[value]);
    return result;
  }
  static Future<String> barcodeSetScanMode(int value) async {
    final String result = await _channel.invokeMethod('barcodeSetScanMode',[value]);
    return result;
  }
  static Future<String> barcodeSetScanBeep(bool enabled,List<int> beepData) async {
    final String result = await _channel.invokeMethod('barcodeSetScanBeep',[enabled,[beepData]]);
    return result;
  }
  static Future<String> setCharging(bool value) async {
    final String result = await _channel.invokeMethod('setCharging',[value]);
    return result;
  }
  static Future<String> updateFirmwareData() async {
    final String result = await _channel.invokeMethod('updateFirmwareData');
    return result;
  }
  static Future<String> emsrSetEncryption(int encryption,int keyID,Map<List, num> params) async {  // optional algorithm parameters.
    final String result = await _channel.invokeMethod('emsrSetEncryption',[encryption,keyID,params]);
    return result;
  }
  static Future<String> emsrSetActiveHead(int activeHead) async {
    final String result = await _channel.invokeMethod('emsrSetActiveHead',[activeHead]);
    return result;
  }
  static Future<String> emsrConfigMaskedDataShowExpiration(bool showExpiration,bool showServiceCode,int unmaskedDigitsAtStart,int unmaskedDigitsAtEnd,int unmaskedDigitsAfter) async {
    final String result = await _channel.invokeMethod('emsrConfigMaskedDataShowExpiration',[showExpiration,showServiceCode,unmaskedDigitsAtStart,unmaskedDigitsAtEnd,unmaskedDigitsAfter]);
    return result;
  }
  static void setMethodCallHandler(Future<dynamic> handler(MethodCall call)){
     _channel.setMethodCallHandler(handler);
  }
  

}
