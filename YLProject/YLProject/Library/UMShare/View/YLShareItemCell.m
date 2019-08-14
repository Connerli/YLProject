//
//  YLShareItemCell.m
//  YLProject
//
//  Created by Conner on 2019/8/13.
//  Copyright © 2019 Conner. All rights reserved.
//

#import "YLShareItemCell.h"

@interface YLShareItemCell ()
@property (nonatomic, strong) UIImageView *iconImageview;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation YLShareItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)setModel:(YLShareItemModel *)model {
    self.iconImageview.image = [UIImage imageNamed:model.iconName];
    self.nameLabel.text = model.name;
}

#pragma mark - Lazy Load
- (void)creatUI {
    [self.contentView addSubview:self.iconImageview];
    [self.iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(12));
        make.width.height.equalTo(@50);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageview.mas_bottom).offset(6);
        make.centerX.equalTo(@0);
    }];
    
}

- (UIImageView *)iconImageview
{
    if (_iconImageview == nil) {
        _iconImageview = [[UIImageView alloc] init];
    }
    return _iconImageview;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor hexString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}
@end
