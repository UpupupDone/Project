//
//  UINavigationController+RetainCycle.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "UINavigationController+RetainCycle.h"
#import "NSObject+SwizzleMethod.h"
#import "QCViewModelProtocol.h"
#import "QCBaseViewController.h"
#import <objc/Runtime.h>
#import <KVOController/KVOController.h>

const void* const kIsCallPop = &kIsCallPop;

@implementation UINavigationController (RetainCycle)

+ (void)load {
    [self qc_swizzleInstanceMethod:@selector(popViewControllerAnimated:) with:@selector(mvvm_popViewControllerAnimated:)];
}

- (UIViewController *)mvvm_popViewControllerAnimated:(BOOL)animated {
    
    UIViewController* popViewController = [self mvvm_popViewControllerAnimated:animated];
    objc_setAssociatedObject(popViewController, kIsCallPop, @(YES), OBJC_ASSOCIATION_RETAIN);
    return popViewController;
}
@end
