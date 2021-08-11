//
//  QCSingletonViewController.m
//  QCSingleton
//
//  Created by MELO on 2021/2/27.
//

#import "QCSingletonViewController.h"
#import "SynchronizedSingleton.h"
#import "SemaphoreSingleton.h"
#import "DispatchOnceSingleton.h"
#import "LockSingleton.h"

//打印耗时
#define Code_execution_time(...)\
CFAbsoluteTime time = CFAbsoluteTimeGetCurrent(); \
__VA_ARGS__; \
NSLog(@"代码行：%d 执行时间为：%lf s", __LINE__, CFAbsoluteTimeGetCurrent() - time);

@interface QCSingletonViewController ()

@end

@implementation QCSingletonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self test1];
    [self test2];
    [self test3];
    [self test4];
}

- (void)test1 {
    Code_execution_time([SynchronizedSingleton synchronizedManager]);
    NSLog(@"Synchronized⏫ =================== %p", [SynchronizedSingleton synchronizedManager]);
}

- (void)test2 {
    Code_execution_time([SemaphoreSingleton semaphoreManager]);
    NSLog(@"Semaphore⏫ =================== %p", [SemaphoreSingleton semaphoreManager]);
}

- (void)test3 {
    Code_execution_time([DispatchOnceSingleton dispatchOnceManager]);
    NSLog(@"DispatchOnce⏫ =================== %p", [DispatchOnceSingleton dispatchOnceManager]);
}

- (void)test4 {
    Code_execution_time([LockSingleton lockManager]);
    NSLog(@"Lock⏫ =================== %p", [LockSingleton lockManager]);
}

@end
