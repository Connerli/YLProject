//
//  UIScrollView+YLBlankPage.m
//  YETApp
//
//  Created by Conner on 2019/4/22.
//  Copyright © 2019年 Conner. All rights reserved.
//

#import "UIScrollView+YLBlankPage.h"
#import <objc/runtime.h>

#define PLACE_TIP_TITLE_FONT                    [UIFont systemFontOfSize:13]
//color
#define PLACE_TIP_TITLE_COLOR                   [UIColor hexString:@"#666666"]
//高亮色
#define PLACE_HIGHLIGHT_COLOR                   [UIColor hexString:@"#333333"]
//行间距
#define PLACEIMAGE_LINE_SPACE                       6.f        //行间距
#define PLACEIMAGE_BUTTON_TAG                       999000991  //按钮
#define PLACEIMAGE_COVER_TAG                        999000992  //图片
#define PLACEIMAGE_TIPLABEL_TAG                     999000993  //文字

static const char *placeImage_button_eventBlock         = "placeImage_button_eventBlock";
static const char *placeLable_eventBlock                = "placeLable_eventBlock";
static const char *scrollview_placeimage_type_tag       = "scrollview_placeimage_type_tag";

NSString *const textRange = @"textRange";
NSString *const textLine = @"textLine";

@implementation UIScrollView (YLBlankPage)

- (void)setPlaceImageType:(PlaceImageType)placeImageType
{
    objc_setAssociatedObject(self, scrollview_placeimage_type_tag, @(placeImageType), OBJC_ASSOCIATION_RETAIN);
}

- (PlaceImageType)placeImageType
{
    NSInteger value = [objc_getAssociatedObject(self, scrollview_placeimage_type_tag) integerValue];
    return (PlaceImageType)value;
}

- (void)setPlaceImageClickBlock:(PlaceImageBlock)block
{
    objc_setAssociatedObject(self, placeImage_button_eventBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (PlaceImageBlock)placeImageClickBlock
{
    return objc_getAssociatedObject(self, placeImage_button_eventBlock);
}

- (void)setPlaceLabelBlock:(PlaceLabelBlock)placeLabelBlock {
    objc_setAssociatedObject(self,placeLable_eventBlock, placeLabelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (PlaceLabelBlock)placeLabelBlock {
    return objc_getAssociatedObject(self, placeLable_eventBlock);
}

- (void)showPlaceImageWithType:(PlaceImageType)type
{
    [self showPlaceImageWithType:type contentOffset:CGPointMake(0, 0)];
}

- (void)showPlaceImageWithType:(PlaceImageType)type contentOffset:(CGPoint)offset
{
    //按钮+图片区域
    UIButton* button = (UIButton *)[self viewWithTag:PLACEIMAGE_BUTTON_TAG];
    if (!button || [self placeImageType] != type) {
        if ([self placeImageType] != type) {
            self.placeImageType = type;
        }
       
        if (button) {
            button.hidden = NO;
            [self bringSubviewToFront:button];
            //设置按钮图片，设置按钮大小与未知
            [self p_setPlaceButton:button type:type contentOffset:offset];
            
        } else if (!button) {
            //初始化按钮
            button = [[UIButton alloc] init];
            [button addTarget:self action:@selector(p_placeImageClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = PLACEIMAGE_BUTTON_TAG;
            
            UIImageView* cover = [[UIImageView alloc] init];
            cover.userInteractionEnabled = NO;
            cover.tag = PLACEIMAGE_COVER_TAG;
            [button addSubview:cover];
            [self addSubview:button];
            
            //设置按钮图片，设置按钮大小与未知
            [self p_setPlaceButton:button type:type  contentOffset:offset];
            [self bringSubviewToFront:button];
        }
    } else {
        //设置按钮图片，设置按钮大小与未知
        [self p_setPlaceButton:button type:type contentOffset:offset];
    }
}

//设置按钮的图片和大小
- (void)p_setPlaceButton:(UIButton *)button type:(PlaceImageType)type  contentOffset:(CGPoint)offset
{
    
    CGFloat headHeight = 0.f;
    if ([self isKindOfClass:[UITableView class]]) {
        headHeight = [(UITableView*)self tableHeaderView].height;
        self.mj_footer.hidden = YES;
    }
    
    //文本<Label>区域
    YYLabel* tipLabel = (YYLabel *)[self viewWithTag:PLACEIMAGE_TIPLABEL_TAG];
    
    if (!tipLabel) {
        tipLabel = [[YYLabel alloc] init];
        tipLabel.hidden = NO;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.numberOfLines = 0;
        tipLabel.tag = PLACEIMAGE_TIPLABEL_TAG;
        [self addSubview:tipLabel];
    }
    
    NSAttributedString *attrTip = [NSAttributedString new];
    attrTip =  [self tipAttributedForType:type];
    tipLabel.attributedText = attrTip;
    
    if (attrTip.length > 0) {
        tipLabel.hidden = NO;
        tipLabel.attributedText = attrTip;
    }else{
        tipLabel.hidden = YES;
    }
    
    UIImageView* cover = [button viewWithTag:PLACEIMAGE_COVER_TAG];
    
    [self configImageWithImageView:cover btn:button type:type];
    CGFloat tipHeight = 0;
    CGFloat tipWidth = 0;
    if (!tipLabel.hidden) {
        UIFont *tipFont = PLACE_TIP_TITLE_FONT;
        CGSize tipSize = [tipLabel sizeThatFits:CGSizeMake(self.width, MAX(tipFont.pointSize,  20))];
        tipHeight = tipSize.height;
        tipWidth = tipSize.width;
    }
    
    CGFloat contentHeight = self.contentSize.height;
    CGFloat centerY;
    if (headHeight == 0) {
        centerY = self.height / 2.0 - (tipHeight + button.height) / 2;
    }else {
        centerY = headHeight + button.height / 2.0 + 80;
    }
    
    if (!tipLabel.hidden) {
        self.contentSize = CGSizeMake(self.width, MAX(headHeight + button.height + 120 + tipHeight , contentHeight));
    }else{
        self.contentSize = CGSizeMake(self.width, MAX(headHeight + button.height + 100, contentHeight));
    }
    
    if (centerY - button.height / 2.0 <= 0) {
        centerY += button.height / 2.0;
    }
    
    button.center = CGPointMake(self.width / 2.f + offset.x, centerY + offset.y);
    cover.frame = button.bounds;
    
    if (!tipLabel.hidden) {
        [tipLabel setFrame:CGRectMake(button.centerX - tipWidth / 2, button.bottom + 20, tipWidth, tipHeight)];
    }
}

//文字添加attribute 颜色 大小  高亮
- (NSMutableAttributedString *)tipAttributedForType:(PlaceImageType)type
{
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSArray *tips = [self tipsForType:type];
    
    for (int i = 0; i < tips.count ; i ++) {
        NSString *tip = tips[i];
        NSString *newText = tip;
        if (i > 0) {
            newText = [NSString stringWithFormat:@"%@%@",@"\n",tip];
        }
        NSMutableAttributedString *tag = [[NSMutableAttributedString alloc] initWithString:newText];
        tag.yy_font = PLACE_TIP_TITLE_FONT;
        tag.yy_lineSpacing = PLACEIMAGE_LINE_SPACE;
        tag.yy_color = PLACE_TIP_TITLE_COLOR;
        tag.yy_lineBreakMode = NSLineBreakByWordWrapping;
        tag.yy_alignment = NSTextAlignmentCenter;
        [self addTextHighlightingLine:i tagString:tag type:type];
        [attrText appendAttributedString:tag];
    }
    
    return attrText;
}

//隐藏
- (void)hidePlaceImageView
{
    if ([self isKindOfClass:[UITableView class]]) {
        self.mj_footer.hidden = NO;
    }
    UIButton* button = (UIButton *)[self viewWithTag:PLACEIMAGE_BUTTON_TAG];
    if (button) {
        button.hidden = YES;
    }
    
    YYLabel* tipLabel = (YYLabel *)[self viewWithTag:PLACEIMAGE_TIPLABEL_TAG];
    if (tipLabel) {
        tipLabel.hidden = YES;
    }
    
    self.placeImageType = PlaceImageTypeNone;
}

- (void)p_placeImageClicked:(id)sender
{
    UIButton* button = (UIButton *)[self viewWithTag:PLACEIMAGE_BUTTON_TAG];
    if (button) {
        if (self.placeImageClickBlock) {
            self.placeImageClickBlock(self.placeImageType);
        }
    }
}

- (void)labelClick:(NSRange)range line:(NSInteger)line tagString:(NSMutableAttributedString *)tag {
    [tag yy_setTextHighlightRange:range color:PLACE_HIGHLIGHT_COLOR backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (self.placeLabelBlock) {
            self.placeLabelBlock(line, self.placeImageType);
        }
        //点击了网络加载图
        if (self.placeImageType == PlaceImageTypeNetworkLost) {
   
        }
    }];
    
}

#pragma mark - 需要单独定义的样式 图片 文字 高亮
//配置图片
- (void)configImageWithImageView:(UIImageView *)cover btn:(UIButton *)button type:(PlaceImageType)type {
    switch (type) {
        case PlaceImageTypeNone:
            break;
        case PlaceImageTypeNetworkLost:
        {
            cover.image = [UIImage imageNamed:@"overall_no_wifi"];
            button.width = 500 / 2.0f;
            button.height = 420 / 2.0f;
        }
            break;
        case PlaceImageTypeServerError:
        {
            cover.image = [UIImage imageNamed:@"server_error_placeholder"]; // @"server_error_placeholder"
            button.width = 388 / 2.0f;
            button.height = 282 / 2.0f;
        }
            break;
        default:
            break;
    }
}

// 配置文字内容
- (NSArray *)tipsForType:(PlaceImageType)type
{
    switch (type) {
        case PlaceImageTypeNone:
        {
            return @[];
        }
            break;
        case PlaceImageTypeNetworkLost:
        {
            return @[@"网络不可用，请检查网络~",@"查看网络设置详情 >"];
        }
            break;
        case PlaceImageTypeServerError: {
            return @[@"系统繁忙，请点击重试~"];
        }
            break;
        default:
            //空
            return @[];
            break;
    }
}

// 配置文字高亮点击事件
- (void)addTextHighlightingLine:(NSInteger )line tagString:(NSMutableAttributedString *)tag type:(PlaceImageType) type {
    switch (type) {
        case PlaceImageTypeNetworkLost: {
            if (line == 1) {
                [self labelClick:NSMakeRange(0, tag.string.length) line:line tagString:tag];
            }
        }
            break;
        case PlaceImageTypeServerError:
            [self labelClick:NSMakeRange(0, tag.string.length) line:line tagString:tag];
            break;
        default:
            break;
    }
}
@end
