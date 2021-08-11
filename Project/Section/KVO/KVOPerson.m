//
//  KVOPerson.m
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import "KVOPerson.h"

@implementation KVOPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [[KVODog alloc] init];
        _arr = [NSMutableArray array];
    }
    return self;
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"dog"]) {
        
        // 此处一定要带下划线
        NSArray *arr = @[@"_dog.name", @"_dog.age"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:arr];
    }
    return keyPaths;
}

//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//
//    if ([key isEqualToString:@"name"]) {
//        return NO;
//    }
//    return YES;
//}

@end
