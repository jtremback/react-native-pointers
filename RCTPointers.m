#import "RCTPointers.h"

@implementation RCTPointers

- (id)init {
  if ((self = [super init])) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:(@selector(onPointerRequest:)) name:@"RCTPointersRequest" object:nil];
    
    self.RCTPointersDict = [[NSMutableDictionary alloc] init];
  }
  NSLog(@"The code runs through here!");
  return self;
}

- (void)onPointerRequest:(NSNotification*)note {
  NSString *pointer = [note.userInfo objectForKey:@"pointer"];
  if ([self.RCTPointersDict objectForKey:pointer]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:pointer object:self];
  }
}

- (void)resolvePointer:(NSString*)pointer usingBlock:(void (^)(id value))usingBlock {
  
  NSObject *observer = [[NSNotificationCenter defaultCenter] addObserverForName:pointer object:nil queue:nil usingBlock:^(NSNotification *note) {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:pointer object:nil];
    NSObject *value = [note.object getPointerValue:pointer];
    usingBlock(value);
  }];
  
  // This must come after the addition of the observer
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RCTPointersRequest" object:self userInfo:@{ @"pointer": pointer }];
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
