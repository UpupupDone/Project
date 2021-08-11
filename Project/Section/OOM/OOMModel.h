//
//  OOMModel.h
//  OOM
//
//  Created by MELO on 2021/02/23.
//  Copyright © 2021 MELO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OOMModel : NSObject

+ (double)usedMemory;

+ (double)availableMemory;

+ (NSString *)callStack;

@end

NS_ASSUME_NONNULL_END
