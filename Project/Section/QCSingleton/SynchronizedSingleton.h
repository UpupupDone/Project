//
//  SynchronizedSingleton.h
//  QCSingleton
//
//  Created by MELO on 2021/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SynchronizedSingleton : NSObject

+ (instancetype)synchronizedManager;

@end

NS_ASSUME_NONNULL_END
