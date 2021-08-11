//
//  NSObject+Bind.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "NSObject+Bind.h"
#import <KVOController/KVOController.h>
#import <objc/message.h>

@implementation NSObject (Bind)

- (void)bind:(NSString *)sourceKeyPath to:(id)target at:(NSString *)targetKeyPath {
    
    [self.KVOController observe:self keyPath:sourceKeyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        id newValue = change[NSKeyValueChangeNewKey];
   
        if ([self verification:newValue]) {
            [target setValue:newValue forKey:targetKeyPath];
        }
    }];
}

- (void)bind:(NSString *)sourceKeyPath bindHandler:(BindHandler)handler {
    
    [self.KVOController observe:self keyPath:sourceKeyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        id newValue = change[NSKeyValueChangeNewKey];
      
        if ([self verification:newValue]) {
            handler(newValue);
        }
    }];
}

- (void)bind:(NSString *)sourceKeyPath to:(id)target selector:(SEL)sel {
    
    [self.KVOController observe:self keyPath:sourceKeyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        id newValue = change[NSKeyValueChangeNewKey];
        if ([self verification:newValue]) {
//            objc_msgSend(target, sel, newValue);
        }
        
    }];
}


- (BOOL)verification:(id)newValue {
    if ([newValue isEqual: [NSNull null]]) {
        return NO;
    }
    return YES;
}

@end
