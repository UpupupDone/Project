//
//  SynchronizedSingleton.m
//  QCSingleton
//
//  Created by MELO on 2021/2/27.
//

#import "SynchronizedSingleton.h"

@interface SynchronizedSingleton ()<NSCopying, NSMutableCopying>

@end

@implementation SynchronizedSingleton

static SynchronizedSingleton *singleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self synchronizedManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] synchronizedManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] synchronizedManager];
}

+ (instancetype)synchronizedManager {
    
    @synchronized (self) {
        if (!singleton) {
            singleton = [[super allocWithZone:NULL] init];
        }
    }
    return singleton;
}

@end
