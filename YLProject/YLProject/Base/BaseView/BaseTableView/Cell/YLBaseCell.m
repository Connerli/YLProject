//
//  CYBaseCell.m
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "YLBaseCell.h"

@implementation YLBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configInit];
    }
    return self;
}

- (void)configInit {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(YLBaseCellModel *)model {
    return 0.f;
}

@end
