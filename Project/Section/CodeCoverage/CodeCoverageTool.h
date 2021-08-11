//
//  CodeCoverageTool.h
//  Project
//
//  Created by MELO on 2021/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeCoverageTool : NSObject

+ (instancetype)sharedManager;

- (void)flush;

@end

NS_ASSUME_NONNULL_END
