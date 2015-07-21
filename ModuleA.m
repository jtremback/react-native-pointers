#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import "RCTPointers.h"

#import "ModuleA.h"

@implementation ModuleA

RCT_EXPORT_MODULE();

- (id)init {
  if ((self = [super init])) {
    self.RCTPointers = [[RCTPointers alloc] init];
  }
  
  return self;
}

RCT_EXPORT_METHOD(send:(RCTResponseSenderBlock)callback) {
  CGSize size = CGSizeMake(5000, 5000);
  UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  callback(@[[NSNull null], [self.RCTPointers createPointer:image]]);
}

@end

