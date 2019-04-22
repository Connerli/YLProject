//
//  CYBaseCell.m
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 HuaLing. All rights reserved.
//

#import "CYBaseCell.h"

@implementation CYBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(CYBaseCellModel *)model {
    return 0.f;
}

@end
