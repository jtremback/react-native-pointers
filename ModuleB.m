#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import "RCTPointers.m"

@interface ModuleB : NSObject <RCTBridgeModule>

@property(strong) RCTPointers *RCTPointers;

@end

@implementation ModuleB

RCT_EXPORT_MODULE();

- (id)init {
  if ((self = [super init])) {
    self.RCTPointers = [[RCTPointers alloc] init];
  }
  
  return self;
}

RCT_EXPORT_METHOD(reciever:(NSDictionary *)params callback:(RCTResponseSenderBlock)callback) {
  NSString *image = params[@"image"];

  [self.RCTPointers resolvePointer:image usingBlock:^(NSObject *image) {
    UIImage *image = UIImage(image);
    callback(@[[NSNull null], image.size]);
  }];
}

@end

