//
//  NSObject+Bind.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BindHandler)(id value);

@class FBKVOController;
@interface NSObject (Bind)

- (void)bind: (NSString * _Nullable)sourceKeyPath to:(id)target at:(NSString * _Nullable)targetKeyPath;

- (void)bind: (NSString * _Nullable)sourceKeyPath bindHandler: (BindHandler)handler;

- (void)bind: (NSString * _Nullable)sourceKeyPath to:(id)target selector:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
