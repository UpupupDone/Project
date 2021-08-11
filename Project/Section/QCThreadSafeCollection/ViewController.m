//
//  ViewController.m
//  QCThreadSafeCollection
//
//  Created by MELO on 2021/2/27.
//

#import "ViewController.h"
#import "QCThreadSafeMutableArray.h"

@interface ViewController ()

@property (nonatomic, strong) QCThreadSafeMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testArrWithGCD];
}

- (void)testArrWithGCD {
    
    self.arr = [QCThreadSafeMutableArray new];
    [self.arr addObjectsFromArray:@[@"0", @"1"]];
    dispatch_queue_t queue = dispatch_queue_create("com.melo.que", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
//        for (NSInteger i = 0; i < 50; i++) {
//
//            //            [NSThread sleepForTimeInterval:1.f];
//            NSString *item = [NSString stringWithFormat:@"%ld", (long)i];
//            [self.arr addObject:item];
//            NSLog(@"添加元素%@", item);
//        }
        [self.arr removeObjectAtIndex:1];
        NSLog(@"removeObjectAtIndex ===== %@", self.arr);
    });
    
    dispatch_async(queue, ^{
        
//        for (NSInteger i = 0; i < 50; i++) {
//
//            //            [NSThread sleepForTimeInterval:1.f];
//            NSString *last = [self.arr lastObject];
//            if (last) {
//                [self.arr removeObject:last];
//                NSLog(@"移除最后一个元素%@", last);
//            } else {
//                NSLog(@"移除领先了%@", last);
//            }
//        }
        [self.arr replaceObjectAtIndex:1 withObject:@"2"];
        NSLog(@"replaceObjectAtIndex ======= %@", self.arr);
    });
    
}

@end
