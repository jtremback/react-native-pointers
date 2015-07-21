#import <Foundation/Foundation.h>

@interface RCTPointers : NSObject

@property(strong) NSMutableDictionary *RCTPointersDict;

- (void)resolvePointer:(NSString*)pointer usingBlock:(void (^)(id value))usingBlock;
- (NSString*)createPointer:(NSObject*)value;

@end
