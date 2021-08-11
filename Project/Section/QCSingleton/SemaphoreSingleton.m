//
//  SemaphoreSingleton.m
//  QCSingleton
//
//  Created by MELO on 2021/2/27.
//

#import "SemaphoreSingleton.h"

@interface SemaphoreSingleton ()<NSCopying, NSMutableCopying>

@end

@implementation SemaphoreSingleton

static SemaphoreSingleton *singleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self semaphoreManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] semaphoreManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] semaphoreManager];
}

static dispatch_semaphore_t semaphore = nil;
+ (void)initialize {
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
    }
}

+ (instancetype)semaphoreManager {
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (!singleton) {
        singleton = [[super allocWithZone:NULL] init];
    }
    dispatch_semaphore_signal(semaphore);
    return singleton;
}

@end
