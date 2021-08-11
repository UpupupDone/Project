//
//  Factory.h
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/** 工厂模式
 * Factory为抽象工厂类，不使用抽象类，使用子类。
 * 没创建一个model，需要需要一个单独的工厂，工厂与model的关系，一对一。工厂模式相当于在简单工厂模式的基础上，对工厂进行二次分解。
 * 优缺点：降低了工厂类的内聚，满足了类之间的层次关系，又很好的符合了面向对象设计中的单一职责原则，这样有利于程序的拓展
 */
@interface Factory : NSObject

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
