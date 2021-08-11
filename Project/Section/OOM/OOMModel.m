//
//  OOMModel.m
//  OOM
//
//  Created by MELO on 2021/02/23.
//  Copyright © 2021 MELO. All rights reserved.
//

#import "OOMModel.h"
#import "mach/mach.h"
#import <os/proc.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@implementation OOMModel

+ (double)usedMemory {
    task_vm_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&taskInfo, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return 0;
    }
    return (long long)taskInfo.phys_footprint / 1024.0 / 1024.0;
}

+ (double)availableMemory {
    if (@available(iOS 13.0, *)) {
        double size = os_proc_available_memory() / 1024.0 / 1024.0;
        return [self usedMemory] + size;
    } else {
        vm_statistics_data_t vmStats;
        mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
        kern_return_t kernReturn = host_statistics(mach_host_self(),
                                                   HOST_VM_INFO,
                                                   (host_info_t)&vmStats,
                                                   &infoCount);
        if (kernReturn != KERN_SUCCESS) {
            return NSNotFound;
        }
        return (long long)vm_page_size * vmStats.free_count / 1024.0 / 1024.0;
    }
}

+ (NSString *)callStack {
    
    //    NSLog(@"=====>>>>>堆栈<<<<<=====\n%@", [NSThread callStackSymbols]);
    
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
    for (i = 0; i < 12; i++) {
        
        NSString *subStr = [NSString stringWithUTF8String:strs[i]];
        [backtrace addObject: subStr];
        NSString *constStr = [NSString stringWithFormat:@"%@\n", subStr];
        [str appendString:constStr];
    }
    free(strs);
    NSLog(@"=====>>>>>堆栈<<<<<=====\n%@", backtrace);
    return str;
}

@end
