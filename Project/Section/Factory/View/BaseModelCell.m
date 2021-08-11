//
//  BaseModelCell.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "BaseModelCell.h"

@interface BaseModelCell ()

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation BaseModelCell

- (void)setModel:(BaseModel *)model {
    self.titleLab.text = model.title;
    self.titleLab.textColor = [UIColor performSelector:NSSelectorFromString(model.color)];
}

- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.frame = self.contentView.bounds;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
    }
    return _titleLab;
}

@end
