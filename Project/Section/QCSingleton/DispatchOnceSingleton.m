//
//  DispatchOnceSingleton.m
//  QCSingleton
//
//  Created by MELO on 2021/2/27.
//

#import "DispatchOnceSingleton.h"

@interface DispatchOnceSingleton ()<NSCopying, NSMutableCopying>

@end

@implementation DispatchOnceSingleton

static DispatchOnceSingleton *singleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self dispatchOnceManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] dispatchOnceManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] dispatchOnceManager];
}

static dispatch_once_t predicate;
+ (instancetype)dispatchOnceManager {
    
    dispatch_once(&predicate, ^{
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

@end
