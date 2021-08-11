//
//  CodeCoverageTool.m
//  Project
//
//  Created by MELO on 2021/4/11.
//

#import "CodeCoverageTool.h"

@interface CodeCoverageTool()

@end

@implementation CodeCoverageTool

- (instancetype)init {
    self = [super init];

    if (self) {

    }

    return self;
}

+ (instancetype)sharedManager {
    
    static CodeCoverageTool *ct = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ct = [[[self class] alloc] init];
    });

    return ct;
}

// 主要生成代码覆盖数据的函数
- (void)flush {
    if (![self enabled]) {
        return ;
    }

  // 确认不是iPhone模拟器，然后设置代码覆盖结果文件的存储路径
#if !TARGET_IPHONE_SIMULATOR
    NSString *covFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xperia_coverage_files"];
    setenv("GCOV_PREFIX", [covFilePath cStringUsingEncoding: NSUTF8StringEncoding], 1);
    setenv("GCOV_PREFIX_STRIP", "100", 1);
#endif

    [self flushCodeCoverage];
}

// 是否开启了代码覆盖开关
- (BOOL)enabled {
    return YES;
}

// 文中提到的写入覆盖数据的核心代码，封装成该函数
- (void)flushCodeCoverage {
    
    extern void __gcov_flush(void);
    __gcov_flush();
}

@end
