//
//  QCThreadSafeCollectionViewController.m
//  QCThreadSafeCollection
//
//  Created by MELO on 2021/2/27.
//

#import "QCThreadSafeCollectionViewController.h"
#import "QCThreadSafeMutableArray.h"

@interface QCThreadSafeCollectionViewController ()

@property (nonatomic, strong) QCThreadSafeMutableArray *arr;

@end

@implementation QCThreadSafeCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //    [self testArrWithGCD];
    [self testArrWithGCD1];
}

- (void)testArrWithGCD {
    
    self.arr = [QCThreadSafeMutableArray new];
    dispatch_queue_t queue = dispatch_queue_create("com.melo.que", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 50; i++) {
            NSString *item = [NSString stringWithFormat:@"%ld", (long)i];
            [self.arr addObject:item];
            NSLog(@"添加元素%@", item);
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 50; i++) {
            NSString *last = [self.arr lastObject];
            if (last) {
                [self.arr removeObject:last];
                NSLog(@"移除最后一个元素%@", last);
            } else {
                NSLog(@"移除领先了%@", last);
            }
        }
    });
}

- (void)testArrWithGCD1 {
    
    self.arr = [QCThreadSafeMutableArray new];
    [self.arr addObjectsFromArray:@[@"0", @"1"]];
    dispatch_queue_t queue = dispatch_queue_create("com.melo.que", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self.arr removeObjectAtIndex:1];
        NSLog(@"removeObjectAtIndex ===== %@", self.arr);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self.arr replaceObjectAtIndex:1 withObject:@"2"];
        NSLog(@"replaceObjectAtIndex ======= %@", self.arr);
    });
}

@end
