#import "InfineasdkPlugin.h"

@implementation InfineasdkPlugin

FlutterMethodChannel* channel;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  channel = [FlutterMethodChannel
      methodChannelWithName:@"infineasdk"
            binaryMessenger:[registrar messenger]];
  InfineasdkPlugin* instance = [[InfineasdkPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [self setDeveloperKey];
  [self connect];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if([@"sdkVersion" isEqualToString:call.method]){
    [self sdkVersion:result];
  }
  else if([@"getConnectedDeviceInfo" isEqualToString:call.method]){
    [self getConnectedDeviceInfo:result];
  }
  else if([@"getConnectedDevicesInfo" isEqualToString:call.method]){
    [self getConnectedDevicesInfo:result];
  }
  else if([@"setPassThroughSync" isEqualToString:call.method]){
    [self setPassThroughSync:result arguments:call.arguments];
  }
  else if([@"getPassThroughSync" isEqualToString:call.method]){
    [self getPassThroughSync:result];
  }
  else if([@"setUSBChargeCurrent" isEqualToString:call.method]){
    [self setUSBChargeCurrent:result arguments:call.arguments];
  }
  else if([@"getUSBChargeCurrent" isEqualToString:call.method]){
    [self getUSBChargeCurrent:result];
  }
  else if([@"getBatteryInfo" isEqualToString:call.method]){
    [self getBatteryInfo:result];
  }
  else if([@"setAutoOffWhenIdle" isEqualToString:call.method]){
    [self setAutoOffWhenIdle:result arguments:call.arguments];
  }
  else if([@"rfInit" isEqualToString:call.method]){
    [self rfInit:result];
  }
  else if([@"rfClose" isEqualToString:call.method]){
    [self rfClose:result];
  }
  else if([@"barcodeGetScanButtonMode" isEqualToString:call.method]){
    [self barcodeGetScanButtonMode:result];
  }
  else if([@"barcodeSetScanButtonMode" isEqualToString:call.method]){
    [self barcodeSetScanButtonMode:result arguments:call.arguments];
  }
  else if([@"barcodeGetScanMode" isEqualToString:call.method]){
    [self barcodeGetScanMode:result];
  }
  else if([@"barcodeSetScanMode" isEqualToString:call.method]){
    [self barcodeSetScanMode:result arguments:call.arguments];
  }
  else if([@"barcodeStartScan" isEqualToString:call.method]){
    [self barcodeStartScan:result];
  }
  else if([@"barcodeStopScan" isEqualToString:call.method]){
    [self barcodeStopScan:result];
  }
  else if([@"setCharging" isEqualToString:call.method]){
    [self setCharging:result arguments:call.arguments];
  }
  else if([@"getFirmwareFileInformation" isEqualToString:call.method]){
    [self getFirmwareFileInformation:result];
  }
  else if([@"barcodeSetScanBeep" isEqualToString:call.method]){
    [self barcodeSetScanBeep:result arguments:call.arguments];
  }
  else if([@"updateFirmwareData" isEqualToString:call.method]){
    [self updateFirmwareData:result];
  }
  else if([@"emsrIsTampered" isEqualToString:call.method]){
    [self emsrIsTampered:result];
  }
  else if([@"emsrGetKeyVersion" isEqualToString:call.method]){
    [self emsrGetKeyVersion:result];
  }
  else if([@"emsrGetDeviceInfo" isEqualToString:call.method]){
    [self emsrGetDeviceInfo:result];
  }
  else if([@"updateFirmwareData" isEqualToString:call.method]){
    [self updateFirmwareData:result arguments:call.arguments];
  }
  else if([@"emsrSetEncryption" isEqualToString:call.method]){
    [self emsrSetEncryption:result arguments:call.arguments];
  }
  else if([@"emsrSetActiveHead" isEqualToString:call.method]){
    [self emsrSetActiveHead:result arguments:call.arguments];
  }
  else if([@"emsrConfigMaskedDataShowExpiration" isEqualToString:call.method]){
    [self emsrConfigMaskedDataShowExpiration:result arguments:call.arguments];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

// SDK API
-(void)sdkVersion: (FlutterResult )result{
    NSLog(@"Call SDK Version");
    int sdk = [self.ipc sdkVersion];
    result([NSNumber numberWithInt:((int)sdk)]);
}

- (void)barcodeSetScanBeep: (FlutterResult )result arguments:(NSMutableArray *)arguments{
    NSLog(@"Call barocdeSetScanBeep");

    BOOL enabled = [arguments[0] boolValue];
    NSError *beepError = nil;
    int volume = 100;
    NSArray *beeps = arguments[1];

    int numberOfData = (int)beeps.count;

    int beepData[numberOfData];
    for (int x = 0; x < numberOfData; x++) {
        beepData[x] = [beeps[x] intValue];
    }

    BOOL isSuccess =[self.ipc barcodeSetScanBeep:enabled volume:volume beepData:beepData length:(int)sizeof(beepData) error:&beepError];
    if(isSuccess){
        result(@"true");
    }
    else{
         result(@"false");
    }

}

- (void)emsrGetKeyVersion:(FlutterResult )result arguments:(NSMutableArray *)arguments{
    NSLog(@"Call emsrGetKeyVersion");

    int keyID = [arguments[0] intValue];
    int keyVersion = -1;
    NSError *error = nil;

    BOOL isSuccess = [self.ipc emsrGetKeyVersion:keyID keyVersion:&keyVersion error:&error];

    if(isSuccess){
        result([NSNumber numberWithInt:((int)keyVersion)]);
    }
    else {
        result(error.localizedDescription);
    }

}

- (void)emsrGetDeviceInfo:(FlutterResult )result{
    NSLog(@"Call emsrGetDeviceInfo");

    NSError *error = nil;
    EMSRDeviceInfo *emsrInfo = [self.ipc emsrGetDeviceInfo:&error];

    if(emsrInfo){
        NSDictionary *emsrInfoDictionary = @{@"ident": emsrInfo.ident,
                                             @"serialNumber": [NSString stringWithFormat:@"%@", emsrInfo.serialNumber],
                                             @"serialNumberString": emsrInfo.serialNumberString,
                                             @"firmwareVersion": @(emsrInfo.firmwareVersion),
                                             @"firmwareVersionString": emsrInfo.firmwareVersionString,
                                             @"securityVersion": @(emsrInfo.securityVersion),
                                             @"securityVersionString": emsrInfo.securityVersionString
                                             };

        result(emsrInfoDictionary);
    }else {
        result(error.localizedDescription);
    }

}

- (void)emsrIsTampered:(FlutterResult )result
{
    NSLog(@"Call emsrIsTampered");

    BOOL isTampered = NO;

    NSError *error = nil;
    BOOL isSuccess = [self.ipc emsrIsTampered:&isTampered error:&error];
    if (!error || isSuccess) {
        result(@"true");
    } else {
        result(error.localizedDescription);
    }

}

- (void)emsrConfigMaskedDataShowExpiration:(FlutterResult )result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call emsrConfigMaskedDataShowExpiration");

    BOOL showExpiration = [[arguments objectAtIndex:0] boolValue];
    BOOL showServiceCode = [[arguments objectAtIndex:1] boolValue];
    int unmaskedDigitsAtStart = [[arguments objectAtIndex:2] intValue];
    int unmaskedDigitsAtEnd = [[arguments objectAtIndex:3] intValue];
    int unmaskedDigitsAfter = [[arguments objectAtIndex:4] intValue];

    NSError *error = nil;
    BOOL isSuccess = [self.ipc emsrConfigMaskedDataShowExpiration:showExpiration showServiceCode:showServiceCode unmaskedDigitsAtStart:unmaskedDigitsAtStart unmaskedDigitsAtEnd:unmaskedDigitsAtEnd unmaskedDigitsAfter:unmaskedDigitsAfter error:&error];
    if (!error || isSuccess) {
        result(@"true");
    } else {
        result(error.localizedDescription);
    }

}

- (void)emsrSetActiveHead:(FlutterResult )result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call emsrSetActiveHead");

    int active = [[arguments objectAtIndex:0] intValue];

    NSError *error = nil;
    BOOL isSuccess = [self.ipc emsrSetActiveHead:active error:&error];
    if (!error || isSuccess) {
        result(@"true");
    } else {
        result(error.localizedDescription);
    }

}

- (void)emsrSetEncryption:(FlutterResult )result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call emsrSetEncryption");

    int encryption = [[arguments objectAtIndex:0] intValue];
    int keyID = [[arguments objectAtIndex:1] intValue];
    NSDictionary *params = nil;
    if (arguments.count > 2) {
        // Check for null
        id object = [arguments objectAtIndex:2];
        if ([object isKindOfClass:[NSDictionary class]]) {
            params = (NSDictionary *)object;
        }
    }

    NSError *error = nil;
    BOOL isSuccess = [self.ipc emsrSetEncryption:encryption keyID:keyID params:params error:&error];
     if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }

}

- (void)setCharging:(FlutterResult )result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call setCharging");

    BOOL echo = [arguments objectAtIndex:0];

    NSError *error;
    BOOL isSuccess = [self.ipc setCharging:echo error:&error];
    if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeStartScan:(FlutterResult )result
{
    NSLog(@"Call barcodeStartScan");
    NSError *error;
    BOOL isSuccess = [self.ipc barcodeStartScan:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeStopScan:(FlutterResult )result
{
    NSLog(@"Call barcodeStopScan");
    NSError *error;
    BOOL isSuccess = [self.ipc barcodeStopScan:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeGetScanMode:(FlutterResult )result
{
    NSLog(@"Call barcodeGetScanMode");
    NSError *error;
    int scanMode = 1;
    BOOL isSuccess = [self.ipc barcodeGetScanMode:&scanMode error:&error];
    if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeSetScanMode:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call barcodeSetScanMode");
    int echo = [[arguments objectAtIndex:0] intValue];
    NSError *error;
    BOOL isSuccess = [self.ipc barcodeSetScanMode:echo error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeGetScanButtonMode:(FlutterResult)result
{
    NSLog(@"Call barcodeGetScanButtonMode");

    NSError *error;
    int scanButtonMode = 1;
    BOOL isSuccess = [self.ipc barcodeGetScanButtonMode:&scanButtonMode error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)barcodeSetScanButtonMode:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call barcodeSetScanButtonMode");


    int echo = [[arguments objectAtIndex:0] intValue];

    NSError *error;
    BOOL isSuccess = [self.ipc barcodeSetScanButtonMode:echo error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)rfClose:(FlutterResult)result
{
    NSLog(@"Call rfClose");
    NSError *error;
    BOOL isSuccess = [self.ipc rfClose:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)rfInit:(FlutterResult)result
{
    NSLog(@"Call rfInit");
    NSError *error;
    BOOL isSuccess = [self.ipc rfInit:CARD_SUPPORT_PICOPASS_ISO15|CARD_SUPPORT_TYPE_A|CARD_SUPPORT_TYPE_B|CARD_SUPPORT_ISO15|CARD_SUPPORT_FELICA error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)setAutoOffWhenIdle:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call setAutoOffWhenIdle");


    int timeIdle = [[arguments objectAtIndex:0] intValue];
    int timeDisconnected = [[arguments objectAtIndex:1] intValue];

    NSError *error;
    BOOL isSuccess = [self.ipc setAutoOffWhenIdle:timeIdle whenDisconnected:timeDisconnected error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)getBatteryInfo:(FlutterResult)result
{
    NSLog(@"Call getBatteryInfo");
    NSError *error = nil;
    DTBatteryInfo *battInfo = [self.ipc getBatteryInfo:&error];
    if (!error) {
        NSDictionary *info = @{@"voltage": @(battInfo.voltage),
                               @"capacity": @(battInfo.capacity),
                               @"health": @(battInfo.health),
                               @"maximumCapacity": @(battInfo.maximumCapacity),
                               @"charging": @(battInfo.charging),
                               @"batteryChipType": @(battInfo.batteryChipType),
                               @"extendedInfo": battInfo.extendedInfo != nil ? battInfo.extendedInfo : @""
                               };


        result(info);
    } else {
        result(error.localizedDescription);
    }

}

- (void)getUSBChargeCurrent:(FlutterResult)result
{
    NSLog(@"Call getUSBChargeCurrent");
    NSError *error;
    int current = 0;
    BOOL isSuccess = [self.ipc getUSBChargeCurrent:&current error:&error];
    if (!error || isSuccess) {
        result([NSNumber numberWithInt:((int)current)]);
    } else {
        result(error.localizedDescription);
    }

}

- (void)setUSBChargeCurrent:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call setUSBChargeCurrent");
    int echo = [[arguments objectAtIndex:0] intValue];

    NSError *error;
    BOOL isSuccess = [self.ipc setUSBChargeCurrent:echo error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)getPassThroughSync:(FlutterResult)result
{
    NSLog(@"Call getPassThroughSync");
    NSError *error;
    BOOL isEnable = NO;
    BOOL isSuccess = [self.ipc getPassThroughSync:&isEnable error:&error];
    if (!error || isSuccess) {
          result(@"true");
    } else {
            result(error.localizedDescription);
    }

}

- (void)setPassThroughSync:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call setPassThroughSync");
    BOOL echo = [arguments objectAtIndex:0];
    NSError *error;
    BOOL isSuccess = [self.ipc setPassThroughSync:echo error:&error];
   if (!error || isSuccess) {
         result(@"true");
     } else {
         result(error.localizedDescription);
     }
}

- (void)getConnectedDevicesInfo:(FlutterResult)result
{
    NSLog(@"Call getConnectedDevicesInfo");

    NSError *error = nil;

    NSArray *connectedDevices = [self.ipc getConnectedDevicesInfo:&error];

    if (!error) {
        NSMutableArray *devicesInfo = [NSMutableArray new];
        for (DTDeviceInfo *deviceInfo in connectedDevices) {
            NSDictionary *device = @{@"deviceType": @(deviceInfo.deviceType),
                                     @"connectionType": @(deviceInfo.connectionType),
                                     @"name": deviceInfo.name,
                                     @"model": deviceInfo.model,
                                     @"firmwareRevision": deviceInfo.firmwareRevision,
                                     @"hardwareRevision": deviceInfo.hardwareRevision,
                                     @"serialNumber": deviceInfo.serialNumber
                                     };

            [devicesInfo addObject:device];
        }
        result(devicesInfo);
    } else {
        result(error.localizedDescription);
    }

}

- (void)getConnectedDeviceInfo:(FlutterResult)result arguments:(NSMutableArray *)arguments
{
    NSLog(@"Call getConnectedDeviceInfo");
    NSString* echo = [arguments objectAtIndex:0];
    NSError *error = nil;
    DTDeviceInfo *deviceInfo = [self.ipc getConnectedDeviceInfo:[echo intValue] error:&error];
    if (!error) {
        NSDictionary *info = @{@"deviceType": @(deviceInfo.deviceType),
                               @"connectionType": @(deviceInfo.connectionType),
                               @"name": deviceInfo.name,
                               @"model": deviceInfo.model,
                               @"firmwareRevision": deviceInfo.firmwareRevision,
                               @"hardwareRevision": deviceInfo.hardwareRevision,
                               @"serialNumber": deviceInfo.serialNumber
                               };

        result(info);
    } else {
         result(error.localizedDescription);
    }

}

- (void)setDeveloperKey
{

    NSLog(@"Call setDeveloperKey");
    NSError *error;
    self.iq = [IPCIQ registerIPCIQ];
    [self.iq setDeveloperKey:ipcDevKey withError:&error];
    if (error) {
        NSLog(@"Developer Key Error: %@", error.localizedDescription);
    }
    else{
        NSLog(@"Developer Key Set");
    }
    self.ipc = [IPCDTDevices sharedDevice];
}

- (NSURL *)resourcePath
{
    NSURL *pathURL = [[NSBundle mainBundle] resourceURL];
    return [pathURL URLByAppendingPathComponent:@"www/resources"];
}

- (void)getFirmwareFileInformation:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call getFirmwareFileInformation");

    NSString *filePath = firmwareFilePath;
    filePath = [filePath stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSURL *fullFilePathURL = [[self resourcePath] URLByAppendingPathComponent:filePath];

    @try {
        NSData *fileData = [NSData dataWithContentsOfURL:fullFilePathURL];

        if (!fileData) {
            result(@"Unable to read file. Check file path!");
            return;
        }
        else {

            NSError *error = nil;
            NSDictionary *firmwareInfo = [self.ipc getFirmwareFileInformation:fileData error:&error];
            if (!error) {
                result(firmwareInfo);
            } else {
                result(error.localizedDescription);
            }
            return;
        }

    } @catch (NSException *exception) {
        result(exception.reason);
        return;
    }
}

- (void)updateFirmwareData:(FlutterResult)result arguments:(NSMutableArray*)arguments
{
    NSLog(@"Call updateFirmwareData");

    self.ipc = [IPCDTDevices sharedDevice];

    NSString *filePath = firmwareFilePath;
    filePath = [filePath stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSURL *fullFilePathURL = [[self resourcePath] URLByAppendingPathComponent:filePath];

    if (self.ipc.connstate != CONN_CONNECTED) {
        result(@"Device is not connected!");
        return;
    }
    else {
        @try {
            NSData *fileData = [NSData dataWithContentsOfURL:fullFilePathURL];

            if (!fileData) {
                result(@"Unable to read file. Check file path!");
                return;
            }
            else {
                NSError *error = nil;
                BOOL isUpdate = [self.ipc updateFirmwareData:fileData validate:YES error:&error];
                if (!error || isUpdate) {
                    result(@"true");
                } else {
                    result(error.localizedDescription);
                }
                return;
            }

        } @catch (NSException *exception) {
            result(exception.reason);
            return;
        }
    }
}

- (void)connect
{
    NSLog(@"Call connect");
    self.ipc = [IPCDTDevices sharedDevice];
    [self.ipc addDelegate:self];
    [self.ipc connect ];
}

- (void)disconnect:(FlutterResult)result
{
    NSLog(@"Call disconnect");
    self.ipc = [IPCDTDevices sharedDevice];
    [self.ipc disconnect];
}


- (void)callback:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    va_list args;
    va_start(args, format);
    [channel invokeMethod:format arguments:args] // to push data to flutter
    va_end(args);

}


#pragma mark - IPCDeviceDelegate
- (void)connectionState:(int)state
{
    [self callback:@"Infinea.connectionState(%i)", state];
}

- (void)barcodeData:(NSString *)barcode type:(int)type
{
    //*************
    // This send to regular barcodeData as string
    [self callback:@"Infinea.barcodeData(\"%@\", %i)", barcode, type];


    //*************
    // Convert to decimal
    const char *barcodes = [barcode UTF8String];
    NSMutableArray *barcodeDecimalArray = [NSMutableArray new];
    for (int i = 0; i < sizeof(barcodes); i++) {
        NSString *string = [NSString stringWithFormat:@"%02d", barcodes[i]];
        NSLog(@"%@", string);
        [barcodeDecimalArray addObject:string];
    }
    NSString *barcodeDecimalString = [barcodeDecimalArray componentsJoinedByString:@","];

    // Send to barcodeDecimals as decimal array
    [self callback:@"Infinea.barcodeDecimals([%@], %i)", barcodeDecimalString, type];
}

- (void)barcodeNSData:(NSData *)barcode type:(int)type
{
    // Hex data
    NSString *hexData = [NSString stringWithFormat:@"%@", barcode];
    hexData = [hexData stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hexData = [hexData stringByReplacingOccurrencesOfString:@">" withString:@""];
    hexData = [hexData stringByReplacingOccurrencesOfString:@" " withString:@""];

    // Ascii string
    uint8_t *bytes=(uint8_t *)[barcode bytes];
    NSMutableString *escapedString = [@"" mutableCopy];
    for (int x = 0; x < barcode.length;x++)
    {
        [escapedString appendFormat:@"\\x%02X", bytes[x] ];
    }

    [self callback:@"Infinea.barcodeNSData(\"%@\", %i)", hexData, type];
}

- (void)rfCardDetected:(int)cardIndex info:(DTRFCardInfo *)info
{
    NSDictionary *cardInfo = @{@"type": @(info.type),
                               @"typeStr": info.typeStr,
                               @"UID": [NSString stringWithFormat:@"%@", info.UID],
                               @"ATQA": @(info.ATQA),
                               @"SAK": @(info.SAK),
                               @"AFI": @(info.AFI),
                               @"DSFID": @(info.DSFID),
                               @"blockSize": @(info.blockSize),
                               @"nBlocks": @(info.nBlocks),
                               @"felicaPMm": [NSString stringWithFormat:@"%@", info.felicaPMm],
                               @"felicaRequestData": [NSString stringWithFormat:@"%@", info.felicaRequestData],
                               @"cardIndex": @(info.cardIndex)
                               };

    [self callback:@"Infinea.rfCardDetected(%i, %@)", cardIndex, cardInfo];
}

- (void)magneticCardData:(NSString *)track1 track2:(NSString *)track2 track3:(NSString *)track3
{
    [self callback:@"Infinea.magneticCardData(\"%@\", \"%@\", \"%@\")", track1, track2, track3];
}

- (void)magneticCardEncryptedData:(int)encryption tracks:(int)tracks data:(NSData *)data track1masked:(NSString *)track1masked track2masked:(NSString *)track2masked track3:(NSString *)track3 source:(int)source
{
    [self callback:@"Infinea.magneticCardEncryptedData(%i, %i, \"%@\", \"%@\", \"%@\", \"%@\", %i)", encryption, tracks, [NSString stringWithFormat:@"%@", data], track1masked, track2masked, track3, source];
}

- (void)magneticCardReadFailed:(int)source reason:(int)reason
{
    [self callback:@"Infinea.magneticCardReadFailed(%i, %i)", source, reason];
}

- (void)magneticCardReadFailed:(int)source
{
    [self callback:@"Infinea.magneticCardReadFailed(%i, %i)", source, -1];
}

- (void)deviceButtonPressed:(int)which
{
    [self callback:@"Infinea.deviceButtonPressed(%i)", which];
}

- (void)deviceButtonReleased:(int)which
{
    [self callback:@"Infinea.deviceButtonReleased(%i)", which];
}

- (void)firmwareUpdateProgress:(int)phase percent:(int)percent
{
    [self callback:@"Infinea.firmwareUpdateProgress(%i, %i)", phase, percent];
}



@end
