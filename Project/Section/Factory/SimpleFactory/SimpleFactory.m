//
//  SimpleFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "SimpleFactory.h"

@implementation SimpleFactory

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    
    BaseModel *model = nil;
    if ([dic[@"style"] isEqualToString:@"text"]) {
        
        model = [NSClassFromString(@"TextModel") new];
    } else if ([dic[@"style"] isEqualToString:@"image"]) {
       
        model = [NSClassFromString(@"ImageModel") new];
    } else if ([dic[@"style"] isEqualToString:@"music"]) {
       
        model = [NSClassFromString(@"MusicModel") new];
    } else if ([dic[@"style"] isEqualToString:@"video"]) {

        model = [NSClassFromString(@"VideoModel") new];
    } else {
        model = [BaseModel new];
    }
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
