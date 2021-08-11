//
//  TextAndImageAbstractFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "TextAndImageAbstractFactory.h"

@implementation TextAndImageAbstractFactory

- (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    
    BaseModel *model = nil;
    if ([dic[@"style"] isEqualToString:@"text"]) {
        model = [NSClassFromString(@"TextModel") new];
    } else {
        model = [NSClassFromString(@"ImageModel") new];
    }
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
