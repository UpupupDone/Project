//
//  AbstractFactory.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "AbstractFactory.h"

@implementation AbstractFactory

+ (instancetype)factoryWithType:(AbstractFactoryModelType)type {
    
    AbstractFactory *factory = nil;
    switch (type) {
        case AbstractFactoryModelTextAndImage:
            factory = [NSClassFromString(@"TextAndImageAbstractFactory") new];
            break;
        case AbstractFactoryModelMusicAndVideo:
            factory = [NSClassFromString(@"MusicAndVideoAbstractFactory") new];
            break;
        default:
            factory = [self new];
            break;
    }
    return factory;
}

- (BaseModel *)newModelWithDic:(NSDictionary *)dic {
    return nil;
}

@end
