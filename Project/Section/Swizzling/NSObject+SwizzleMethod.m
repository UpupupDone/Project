//
//  NSObject+SwizzleMethod.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

inline BOOL QC_OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

@implementation NSObject (SwizzleMethod)

+ (BOOL)qc_swizzleInstanceMethod:(SEL)oriSel with:(SEL)swiSel {
    
    Method oriMethod = class_getInstanceMethod(self, oriSel);
    Method swiMethod = class_getInstanceMethod(self, swiSel);
    if (!oriMethod || !swiMethod) return NO;
    
    class_addMethod(self,
                    oriSel,
                    class_getMethodImplementation(self, oriSel),
                    method_getTypeEncoding(oriMethod));
    class_addMethod(self,
                    swiSel,
                    class_getMethodImplementation(self, swiSel),
                    method_getTypeEncoding(swiMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, oriSel),
                                   class_getInstanceMethod(self, swiSel));
    [self qc_hookClass:[self class] method:oriSel];
    return YES;
}

+ (BOOL)qc_swizzleClassMethod:(SEL)oriSel with:(SEL)swiSel {
    
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, oriSel);
    Method newMethod = class_getClassMethod(class, swiSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    [self qc_hookClass:[self class] method:oriSel];
    return YES;
}

+ (BOOL)qc_swizzleAddMethod:(SEL)addSel fromClass:(Class)implCls method:(SEL)implSel {
    
    return class_addMethod(self, addSel,
                           class_getMethodImplementation(implCls, implSel),
                           method_getTypeEncoding(class_getInstanceMethod(implCls, implSel)));
}

#pragma mark - hook dataSource
static NSMutableDictionary *tyHookDictionary;

+ (void)tyHookDictionary_init {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tyHookDictionary = [NSMutableDictionary dictionary];
    });
}

+ (void)qc_hookClass:(Class)cls method:(SEL)oriSel {
    
    [self tyHookDictionary_init];
    NSString *className = NSStringFromClass(cls);
    NSString *methodName = NSStringFromSelector(oriSel);
    NSMutableArray *arr = [tyHookDictionary objectForKey:className];
    NSMutableArray *hookMethodArr = [NSMutableArray array];
    
    if (arr.count) {
        [hookMethodArr addObjectsFromArray:arr];
    }
    
    if (![hookMethodArr containsObject:methodName]) {
        [hookMethodArr addObject:methodName];
        [tyHookDictionary setObject:hookMethodArr forKey:className];
    }
}

+ (void)qc_hookMapPrint {
    NSLog(@"hook map ===== %@", tyHookDictionary);
}


@end

