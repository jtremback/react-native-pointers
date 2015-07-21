#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import "RCTPointers.h"

#import "ModuleB.h"

@implementation ModuleB

RCT_EXPORT_MODULE();

- (id)init {
  if ((self = [super init])) {
    self.RCTPointers = [[RCTPointers alloc] init];
  }
  
  return self;
}

RCT_EXPORT_METHOD(receive:(NSString *)imagePointer callback:(RCTResponseSenderBlock)callback) {
  [self.RCTPointers resolvePointer:imagePointer usingBlock:^(NSString *string) {
//    CGSize size = image.size;
    callback(@[[NSNull null], string]);
  }];
}

@end

