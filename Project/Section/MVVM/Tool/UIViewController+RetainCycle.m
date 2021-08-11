//
//  UIViewController+RetainCycle.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "UIViewController+RetainCycle.h"
#import "NSObject+SwizzleMethod.h"
#import "QCViewModelProtocol.h"
#import "QCBaseViewController.h"
#import <objc/Runtime.h>
#import <KVOController/KVOController.h>

const void* const isCallPop = &isCallPop;

@implementation UIViewController (RetainCycle)

+ (void)load {
    [self qc_swizzleInstanceMethod:@selector(viewDidDisappear:) with:@selector(mvvm_viewDidDisappear:)];
}


- (void)mvvm_viewDidDisappear:(BOOL)animated {
    [self mvvm_viewDidDisappear:animated];
    
    if ([objc_getAssociatedObject(self, isCallPop) boolValue]) {
        if ([self isKindOfClass:[QCBaseViewController class]] && [((QCBaseViewController *)self).viewModel conformsToProtocol:@protocol(QCViewModelProtocol)]) {
            NSObject *vm = ((QCBaseViewController *)self).viewModel;
            [vm.KVOController unobserveAll];
        }
    }
}

@end
