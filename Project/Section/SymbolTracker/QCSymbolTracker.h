//
//  QCSymbolTracker.h
//  Project
//
//  Created by MELO on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCSymbolTracker : NSObject

+ (BOOL)exportSymbolsWithFilePath:(nonnull NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
