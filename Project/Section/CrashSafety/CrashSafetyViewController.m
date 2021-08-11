//
//  CrashSafetyViewController.m
//  Project
//
//  Created by MELO on 2021/3/12.
//

#import "CrashSafetyViewController.h"

@implementation KVCCrashObject

@end

@interface CrashSafetyViewController ()

@end

@implementation CrashSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self performSelector:@selector(fun)];
    [[self class] performSelector:@selector(func)];
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    1. key 不是对象的属性，造成崩溃
    [self testKVCCrash1];
    
    //    2. keyPath 不正确，造成崩溃
    [self testKVCCrash2];
    
    //    3. key 为 nil，造成崩溃
    [self testKVCCrash3];
    
    //    4. value 为 nil，为非对象设值，造成崩溃
    [self testKVCCrash4];
}

/**
 1. key 不是对象的属性，造成崩溃
 */
- (void)testKVCCrash1 {
    
    KVCCrashObject *objc = [[KVCCrashObject alloc] init];
    [objc setValue:@"value" forKey:@"address"];
}

/**
 2. keyPath 不正确，造成崩溃
 */
- (void)testKVCCrash2 {
    KVCCrashObject *objc = [[KVCCrashObject alloc] init];
    [objc setValue:@"后厂村路" forKeyPath:@"address.street"];
}

/**
 3. key 为 nil，造成崩溃
 */
- (void)testKVCCrash3 {
    // 崩溃日志：'-[KVCCrashObject setValue:forKey:]: attempt to set a value for a nil key
    
    NSString *keyName;
    // key 为 nil 会崩溃，如果传 nil 会提示警告，传空变量则不会提示警告
    
    KVCCrashObject *objc = [[KVCCrashObject alloc] init];
    [objc setValue:@"value" forKey:keyName];
}

/**
 4. value 为 nil，造成崩溃
 */
- (void)testKVCCrash4 {
    // 崩溃日志：[<KVCCrashObject 0x6000028a6780> setNilValueForKey]: could not set nil as the value for the key XXX.
    
    // value 为 nil 会崩溃
    KVCCrashObject *objc = [[KVCCrashObject alloc] init];
    [objc setValue:nil forKey:@"age"];
}

@end
