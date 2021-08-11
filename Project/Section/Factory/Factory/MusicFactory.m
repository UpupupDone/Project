//
//  MusicFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "MusicFactory.h"

@implementation MusicFactory

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    BaseModel *model = [NSClassFromString(@"MusicModel") new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
