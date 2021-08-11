//
//  BaseModel.h
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 抽象model
@interface BaseModel : NSObject

@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *color;

@end

NS_ASSUME_NONNULL_END
