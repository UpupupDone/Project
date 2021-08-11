//
//  QCDefine.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#ifndef PHDataBaseDefine_h
#define PHDataBaseDefine_h

// 字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqualToString:@"(null)"]) || ([(_ref) isEqualToString:@"(Null)"]) || ([(_ref) isEqualToString:@"(NULL)"]) || ([(_ref) isEqualToString:@"<null>"]) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqualToString:@""]) || ([(_ref) length] == 0))

// 数组是否为空
#define IsArrEmpty(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) count] == 0))

// 类型转换
#define L(_ref) [NSString stringWithFormat:@"%@", _ref]
#define LInteger(_ref) [NSString stringWithFormat:@"%ld", (long)_ref]
#define LLongLong(_ref) [NSString stringWithFormat:@"%lld", (long long)_ref]

// 打印耗时
#define Code_execution_time(...)\
CFAbsoluteTime time = CFAbsoluteTimeGetCurrent(); \
__VA_ARGS__; \
NSLog(@"代码行：%d 执行时间为：%lf s", __LINE__, CFAbsoluteTimeGetCurrent() - time);

#endif /* PHDataBaseDefine_h */
