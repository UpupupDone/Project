//
//  SimpleFactory.h
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/** 简单工厂模式
 *  简单工厂类，创建model(具体的model，非抽象model)，工厂与model的关系，一对多
 *  简单工厂模式的优缺点：
 *  1.工厂类含有必要的创建何种产品的逻辑，这样客户端只需要请求需要的产品，而不需要理会产品的实现细节。
 *  2.工厂类只有一个，它集中了所有产品创建的逻辑，它将是整个系统的瓶颈，同时造成系统难以拓展。
 *  3.简单工厂模式通常使用静态工厂方法，这使得工厂类无法由子类继承，这使得工厂角色无法形成基于继承的等级结构。
 */
@interface SimpleFactory : NSObject

+ (BaseModel *)newModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
