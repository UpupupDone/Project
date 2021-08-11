//
//  NSObject+QCKVO.h
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** KVO的内部实现
 * 1、动态创建一个子类
 * 2、动态修改监听的类型，监听子类
 * 3、子类重写set方法
*/
@interface NSObject (QCKVO)

- (void)melo_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end

NS_ASSUME_NONNULL_END
