#import <Flutter/Flutter.h>
#import <InfineaSDK/InfineaSDK.h>
#import "constants.h"

@interface InfineasdkPlugin : NSObject<FlutterPlugin , IPCDTDeviceDelegate>

@property (strong, nonatomic) IPCIQ *iq;
@property (strong, nonatomic) IPCDTDevices *ipc;

// Available Functions
- (void)setDeveloperKey;
- (void)connect;
- (void)disconnect:(FlutterResult)result;
- (void)sdkVersion:(FlutterResult)result;
- (void)getConnectedDeviceInfo:(FlutterResult)result;
- (void)getConnectedDevicesInfo:(FlutterResult)result;
- (void)setPassThroughSync:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)getPassThroughSync:(FlutterResult)result;
- (void)setUSBChargeCurrent:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)getUSBChargeCurrent:(FlutterResult)result;
- (void)getBatteryInfo:(FlutterResult)result;
- (void)setAutoOffWhenIdle:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)rfInit:(FlutterResult)result;
- (void)rfClose:(FlutterResult)result;
- (void)barcodeGetScanButtonMode:(FlutterResult)result;
- (void)barcodeSetScanButtonMode:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)barcodeGetScanMode:(FlutterResult)result;
- (void)barcodeSetScanMode:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)barcodeStartScan:(FlutterResult)result;
- (void)barcodeStopScan:(FlutterResult)result;
- (void)barcodeSetScanBeep: (FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)setCharging:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)getFirmwareFileInformation:(FlutterResult)result;
- (void)updateFirmwareData:(FlutterResult)result;
- (void)emsrSetEncryption:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)emsrSetActiveHead:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)emsrConfigMaskedDataShowExpiration:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)emsrIsTampered:(FlutterResult)result;
- (void)emsrGetKeyVersion:(FlutterResult)result arguments:(NSMutableArray *)arguments;
- (void)emsrGetDeviceInfo:(FlutterResult)result;

@end
