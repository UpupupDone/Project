//
//  KVCPerson.m
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import "KVCPerson.h"

@implementation KVCPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        _key = @"_key";
//        _isKey = @"_isKey";
//         key = @"key";
//        isKey = @"isKey";
        _dog = [[KVCDog alloc] init];
        _arr = [NSMutableArray array];
    }
    return self;
}

+ (BOOL)accessInstanceVariablesDirectly {
    
    return YES;
}

#pragma mark -setter
- (void)setKey:(NSString *)key {
    NSLog(@"setKey");
}

- (void)_setKey:(NSString *)key {
    NSLog(@"_setKey");
}

- (void)setIsKey:(NSString *)key {
    NSLog(@"setIsKey");
}

#pragma mark - getter

//- (NSString *)getKey {
//    
//    return @"getKey";
//}

//- (NSString *)key {
//
//    return @"key";
//}

//- (NSString *)isKey {
//
//    return @"isKey";
//}

//- (NSString *)_key {
//
//    return @"_key";
//}

#pragma mark - 根据countOfKey、objectInKeyAtIndex生成一个NSKeyValueArray数组并返回
- (NSUInteger)countOfKey {

    return 10;
}

- (id)objectInKeyAtIndex:(NSUInteger)index {

    return @"objc";
}

- (void)desc {
    
//    NSLog(@"_key = %@", _key);
//    NSLog(@"_isKey = %@ ", _isKey);
//    NSLog(@"key = %@", key);
//    NSLog(@"isKey = %@", isKey);
    
}

@end
