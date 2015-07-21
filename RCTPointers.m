#import "RCTPointers.h"

@implementation RCTPointers

- (id)init {
  if ((self = [super init])) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:(@selector(onPointerRequest:)) name:@"RCTPointersRequest" object:nil];
  }
  NSLog(@"The code runs through here!");
  return self;
}

- (void)onPointerRequest:(NSNotification*)note {
  NSString *pointer = [note.userInfo objectForKey:@"pointer"];
  [[NSNotificationCenter defaultCenter] postNotificationName:pointer object:self];
}

- (void)resolvePointer:(NSString*)pointer usingBlock:(void (^)(id value))usingBlock {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RCTPointersRequest" object:self userInfo:@{ @"pointer": pointer }];
  
  NSObject *observer = [[NSNotificationCenter defaultCenter] addObserverForName:pointer object:nil queue:nil usingBlock:^(NSNotification *note) {
    NSObject *value = [note.object getPointerValue:pointer];
    usingBlock(value);
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:pointer object:nil];
  }];
}

- (NSString*)createPointer:(NSObject*)value {
  return [self setPointerValue:value];
}

- (NSString*)setPointerValue:(NSObject*)data {
  NSString *uuid = [[NSUUID UUID] UUIDString];
  [self.RCTPointersDict setObject:data forKey:uuid];
  return uuid;
}

- (NSObject*)getPointerValue:(NSString*)pointer {
  NSObject *data = [self.RCTPointersDict objectForKey:pointer];
  [self.RCTPointersDict removeObjectForKey:pointer];
  return data;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
