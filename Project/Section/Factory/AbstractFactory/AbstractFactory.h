//
//  AbstractFactory.h
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AbstractFactoryModelType) {
    AbstractFactoryModelTextAndImage,
    AbstractFactoryModelMusicAndVideo
};

/**
 * 抽象工厂模式
 * 一个具体的工厂实现，内部创建多个model。
 *
 * 抽象工厂模式的优点
 *（1）分离接口和实现
 * 客户端使用抽象工厂来创建需要的对象，而客户端根本就不知道具体的实现是谁，客户端只是面向产品的接口编程而已。也就是说，客户端从具体的产品实现中解耦。
 *（2）使切换产品族变得容易
 * 因为一个具体的工厂实现代表的是一个产品族，比如上面例子的从Intel系列到AMD系列只需要切换一下具体工厂。
 *
 * 抽象工厂模式的缺点
   不太容易扩展新的产品：如果需要给整个产品族添加一个新的产品，那么就需要修改抽象工厂，这样就会导致修改所有的工厂实现类。
 */
@interface AbstractFactory : NSObject

+ (instancetype)factoryWithType:(AbstractFactoryModelType)type;

- (BaseModel *)newModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
