//
//  QCSymbolTracker.m
//  Project
//
//  Created by MELO on 2021/3/16.
//

#import "QCSymbolTracker.h"
#import <stdint.h>
#import <stdio.h>
#import <sanitizer/coverage_interface.h>
#import <libkern/OSAtomic.h>
#import <dlfcn.h>

/*
 原子队列特点
 1、先进后出
 2、线程安全
 3、只能保存结构体
 */
static  OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

// 符号结构体链表
typedef struct {
    void *pc;
    void *next;
}SymbolNode;


void print_dl_info(void *PC) {
    
    Dl_info info;
    dladdr(PC, &info);
    printf("fnam:%s \n fbase:%p \n sname:%s \n saddr:%p",
           info.dli_fname,  /* Pathname of shared object      函数的路径  */
           info.dli_fbase,  /* Base address of shared object  函数的地址  */
           info.dli_sname,  /* Name of nearest symbol         函数符号    */
           info.dli_saddr); /* Address of nearest symbol      函数起始地址 */
}

#pragma mark - 静态插桩代码
void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                         uint32_t *stop) {
    static uint64_t N;  // Counter for the guards.
    if (start == stop || *start) return;  // Initialize only once.
    printf("INIT: %p %p\n", start, stop);
    for (uint32_t *x = start; x < stop; x++)
    *x = ++N;  // Guards should start from 1.
}

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    // 会导致load 方法被return
    // if (!*guard) return;
    // 获取到本方法结束后，要返回的地址去，这个地址包含在被hook的方法内部，但不是被hook 的方法的首地址
    void *PC = __builtin_return_address(0);
    
    // 创建结构体
    SymbolNode *node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){ PC, NULL };
    
    // 加入队列 offsetof 用在这里是为了入队添加下一个节点，找到前一个节点next指针的位置
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));
    
    // 这里不能直接调用print_dl_info，会崩溃
    //     print_dl_info(PC);
    
    Dl_info info;
    dladdr(PC, &info);
//    printf("fnam:%s \n fbase:%p \n sname:%s \n saddr:%p", info.dli_fname, info.dli_fbase, info.dli_sname,  info.dli_saddr);
//    printf("sname:%s \n", info.dli_sname);
}

@implementation QCSymbolTracker

+ (BOOL)exportSymbolsWithFilePath:(nonnull NSString *)filePath {
    
    NSMutableArray <NSString *>* symbolNames = [NSMutableArray array];
    while (YES) {
        SymbolNode *node = OSAtomicDequeue(&symbolList, offsetof(SymbolNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        
        NSString *name = @(info.dli_sname);
        BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["]; // OC方法不处理
        NSString *symbolName = isObjc? name : [@"_" stringByAppendingString:name]; // C函数、Swift方法前面带下划线
        [symbolNames addObject:symbolName];
    }
    
    NSEnumerator *emt = [symbolNames reverseObjectEnumerator];
    NSMutableArray<NSString*>* funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString *name;
    while (name = [emt nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    // 移除本方法
    [funcs removeObject:[NSString stringWithFormat:@"%s", __FUNCTION__]];
    
    // 将数组变成字符串
    NSString *funcStr = [funcs componentsJoinedByString:@"\n"];
    NSLog(@"funcStr: %@", funcStr);
    
    NSData *fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
    if (result) {
        NSLog(@"filePath: %@", filePath);
    } else{
        NSLog(@"文件写入出错");
    }
    return result;
}

@end
