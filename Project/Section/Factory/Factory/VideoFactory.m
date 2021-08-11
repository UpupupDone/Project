//
//  VideoFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "VideoFactory.h"

@implementation VideoFactory

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    BaseModel *model = [NSClassFromString(@"VideoModel") new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
