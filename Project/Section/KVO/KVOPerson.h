//
//  KVOPerson.h
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import "KVODog.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVOPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) KVODog *dog;
@property (nonatomic, strong) NSMutableArray *arr;

- (void)desc;

@end

NS_ASSUME_NONNULL_END
