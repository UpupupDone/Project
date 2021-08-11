//
//  BaseModelCell.h
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// 抽象cell
@interface BaseModelCell : UITableViewCell

- (void)setModel:(BaseModel *)model;

@end

NS_ASSUME_NONNULL_END
