#import "RCTPointers.h"

@implementation RCTPointers

- (id)init {
  if ((self = [super init])) {
    // Listen for pointer reguests
    [[NSNotificationCenter defaultCenter] addObserver:self selector:(@selector(onPointerRequest:)) name:@"RCTPointersRequest" object:nil];
    // Initialize pointer data storage
    self.RCTPointersDict = [[NSMutableDictionary alloc] init];
  }

  return self;
}

- (void)onPointerRequest:(NSNotification*)note {
  // Unwrap pointer string from NSDictionary
  NSString *pointer = [note.userInfo objectForKey:@"pointer"];
  // Check if this instance of RCTPointers has it
  if ([self.RCTPointersDict objectForKey:pointer]) {
    // If so, send return notification named after pointer, with self attached
    [[NSNotificationCenter defaultCenter] postNotificationName:pointer object:self];
  }
}

- (void)resolvePointer:(NSString*)pointer usingBlock:(void (^)(id value))usingBlock {
  // Ensure that oberserver will be accessible in block
  __block __weak id observer;
  // Set up observer for notification named after pointer
  observer = [[NSNotificationCenter defaultCenter] addObserverForName:pointer object:nil queue:nil usingBlock:^(NSNotification *note) {
    // Remove observer so it only runs once
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:pointer object:nil];
    // Call block with value of pointer from other instance of RCTPointers (note.object)
    usingBlock([note.object getPointerValue:pointer]);
  }];
  
  // This must come after the addition of the observer
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RCTPointersRequest" object:self userInfo:@{ @"pointer": pointer }];
}

- (NSString*)createPointer:(NSObject*)value {
  return [self setPointerValue:value];
}

- (NSString*)setPointerValue:(NSObject*)data {
  // Generate UUID
  NSString *uuid = [[NSUUID UUID] UUIDString];
  // Store data under UUID
  [self.RCTPointersDict setObject:data forKey:uuid];
  // Return pointer
  return uuid;
}

- (NSObject*)getPointerValue:(NSString*)pointer {
  // Assign data to variable
  NSObject *data = [self.RCTPointersDict objectForKey:pointer];
  // Release data from NSDictionary
  [self.RCTPointersDict removeObjectForKey:pointer];
  // Return data
  return data;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
