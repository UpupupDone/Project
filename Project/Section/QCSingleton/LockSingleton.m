//
//  LockSingleton.m
//  Project
//
//  Created by MELO on 2021/3/12.
//

#import "LockSingleton.h"

@implementation LockSingleton

static LockSingleton *singleton = nil;
static NSLock *lock = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self lockManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] lockManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] lockManager];
}

+ (instancetype)lockManager {
    
    [lock lock];
    if (!singleton) {
        singleton = [[super allocWithZone:NULL] init];
    }
    [lock unlock];
    return singleton;
}

@end
