#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
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

RCT_EXPORT_METHOD(receive:(NSString *)imagePointer callback:(RCTResponseSenderBlock)callback) {
  [self.RCTPointers resolvePointer:imagePointer usingBlock:^(UIImage *image) {
    CGSize size = image.size;
    callback(@[[NSNull null], @"size %@", NSStringFromCGSize(size)]);
  }];
}

@end

