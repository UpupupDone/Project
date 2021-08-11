//
//  ImageFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "ImageFactory.h"

@implementation ImageFactory

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    BaseModel *model = [NSClassFromString(@"ImageModel") new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
