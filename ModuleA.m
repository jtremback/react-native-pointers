#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "RCTBridgeModule.h"
#import "RCTLog.h"

@interface FileUpload : NSObject <RCTBridgeModule>
@end

@implementation FileUpload

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(takePhoto:(RCTResponseSenderBlock)callback) {
  NSString *uuid = [[NSUUID UUID] UUIDString];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"citiesListComplete" object:nil userInfo:dictionary];
  
  callback(@[[NSNull null], uuid]);
}

@end

