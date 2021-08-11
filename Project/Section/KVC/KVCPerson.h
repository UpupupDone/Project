//
//  KVCPerson.h
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import "KVCDog.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVCPerson : NSObject
{
//    NSString *_key;
//    NSString *_isKey;
//    NSString *key;
//    NSString *isKey;
}

//@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) KVCDog *dog;
@property (nonatomic, strong) NSMutableArray *arr;

- (void)desc;

@end

NS_ASSUME_NONNULL_END
