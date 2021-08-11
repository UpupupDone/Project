//
//  OOMViewController.m
//  OOM
//
//  Created by MELO on 2021/02/23.
//  Copyright © 2021 MELO. All rights reserved.
//

#import "OOMViewController.h"
#import "OOMModel.h"
#import <mach/mach.h>

@interface OOMViewController ()
{
    NSTimer *timer;
    
    int allocatedMB;
    Byte *p[10000];
    
    // 当前系统情况下最大可用内存
    long long memoryMaxSizeMB;
    
    // 内存警告时的内存
    long long memoryWarningSizeMB;
    
    // 已使用内存
    long long memoryLimitSizeMB;
    
    BOOL firstMemoryWarningReceived;
}

@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end

@implementation OOMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    firstMemoryWarningReceived = YES;
    long long usedMemory = [OOMModel usedMemory];
    memoryMaxSizeMB = [OOMModel availableMemory];
    NSLog(@"availableMemory = %lld, usedMemory = %lld", memoryMaxSizeMB, usedMemory);
    NSLog(@"physicalMemory = %llu", [NSProcessInfo processInfo].physicalMemory / 1024 / 1024);
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(allocateMemory) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (firstMemoryWarningReceived == NO) {
        return ;
    }
    memoryWarningSizeMB = [OOMModel usedMemory];
    NSLog(@"memory warnning = %lldMB", memoryWarningSizeMB);
    firstMemoryWarningReceived = NO;
}

- (void)allocateMemory {
    
    if (memoryWarningSizeMB || memoryLimitSizeMB / (double)memoryMaxSizeMB > 0.85) {
        
        NSLog(@"memory warnning = %lldMB, memory limit = %lldMB", memoryWarningSizeMB, memoryLimitSizeMB);
        self.detailLab.text = [OOMModel callStack];
        [timer invalidate];
        return;
    }
    
    p[allocatedMB] = malloc(1048576);
    memset(p[allocatedMB], 0, 1048576);
    allocatedMB += 1;
    memoryLimitSizeMB = [OOMModel usedMemory];
    
    if (memoryWarningSizeMB) {
        NSLog(@"memory warnning = %lldMB, memory limit = %lldMB", memoryWarningSizeMB, memoryLimitSizeMB);
    } else {
        NSLog(@"memory limit = %lldMB", memoryLimitSizeMB);
    }
}

// 字符串翻转
- (void)charReverse {
    
    NSString *string = @"hello,world";
    NSLog(@"%@", string);
    
    //1、遍历拼接
    //    NSString *str = @"";
    //    for (int i = 0; i < string.length; i++) {
    //
    //        NSString *subStr = [string substringWithRange:NSMakeRange(string.length - 1 - i, 1)];
    //         str = [str stringByAppendingString:subStr];
    //    }
    
    // 2、遍历替换(折半遍历)
    //    NSMutableString *str = [[NSMutableString alloc] initWithString:string];
    //    for (int i = 0; i < (string.length + 1) / 2; i++) {
    //
    //        [str replaceCharactersInRange:NSMakeRange(i, 1) withString:[string substringWithRange:NSMakeRange(string.length - 1 - i, 1)]];
    //        [str replaceCharactersInRange:NSMakeRange(string.length - 1 - i, 1) withString:[string substringWithRange:NSMakeRange(i, 1)]];
    //    }
    
    // 3、交换,指针移动,
    char ch[100];
    memcpy(ch, [string cStringUsingEncoding:NSUTF8StringEncoding], [string length]);
    
    // 设置两个指针，一个指向字符串头，一个指向字符串尾开始
    char *begin = ch;
    char *end = ch + strlen(ch) - 1;
    
    // 遍历字符数组，逐步交换两个指针指向的内容，同时移动指针到对应的下个内容，直到begin >= end
    while (begin < end) {
        
        char temp = *begin;
        
        *(begin++) = *end;
        *(end--) = temp;
    }
    
    NSLog(@"charReverse = []%s", ch);
}

// 合并数组
- (void)mergeArr {
    
    int aLen = 5, bLen = 9;
    
    int a[] = {1, 4, 6, 7, 9};
    int b[] = {2, 3, 5, 6, 8, 9, 10, 11, 12};
    int result[14];
    
    int aIdx = 0, bIdx = 0, resultIdx = 0;
    
    // 任意数组没有达到边界，则进行遍历
    while (aIdx < aLen && bIdx < bLen) {
        
        if (a[aIdx] < b[bIdx]) {
            
            // 如果a数组对应位置的值，小于b数组对应位置的值，则存储a数组的值，并移动a数组的下标与合并结果数组的下标
            result[resultIdx++] = a[aIdx++];
        } else {
            
            // 否则存储b数组的值，并移动b数组的下标与合并结果数组的下标
            result[resultIdx++] = b[bIdx++];
        }
    }
    
    // 如果a数组有剩余，则把a数组剩余的部分拼接到合并结果数组的后面
    while (aIdx < aLen) {
        
        result[resultIdx++] = a[aIdx++];
    }
    
    // 如果b数组有剩余，则把b数组剩余的部分拼接到合并结果数组的后面
    while (bIdx < bLen) {
        
        result[resultIdx++] = b[bIdx++];
    }
    
    [self printList:result length:aLen + bLen];
}

- (void)printList:(int [])list length:(int)length {
    
    for (int i = 0; i < length; i++) {
        
        printf("%d\n", list[i]);
    }
}

@end
