//
//  MusicAndVideoAbstractFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "MusicAndVideoAbstractFactory.h"

@implementation MusicAndVideoAbstractFactory

- (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    
    BaseModel *model = nil;
    if ([dic[@"style"] isEqualToString:@"music"]) {
        model = [NSClassFromString(@"MusicModel") new];
    } else {
        model = [NSClassFromString(@"VideoModel") new];
    }
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
