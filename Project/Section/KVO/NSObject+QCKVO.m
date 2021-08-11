//
//  NSObject+QCKVO.m
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import "NSObject+QCKVO.h"
#import <objc/runtime.h>

@implementation NSObject (QCKVO)

- (void)melo_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    // 新建一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    
    NSString *newClassName = [@"QCKVO_" stringByAppendingString:oldClassName];
    
    // 创建类
    Class newClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
    
    // 注册类
    objc_registerClassPair(newClass);
    
    // 指针混写，修改调用者的类型
    object_setClass(self, newClass);
    
    // 添加set方法
    class_addMethod(newClass, @selector(setName:), (IMP)qcSetName, "v@:@");
}

void qcSetName(id self, SEL _cmd, NSString *name) {
    
    NSLog(@"自定义KVO成功了，qcSetName方法走了%@ %@ %@", self, NSStringFromSelector(_cmd), name);
}

@end
