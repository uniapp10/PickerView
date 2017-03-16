//
//  GXHoldTool.m
//  GXAppNew
//
//  Created by zhudong on 2017/3/8.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import "GXHoldTool.h"

@implementation GXHoldTool

+ (UILabel *)labelWithWeight: (NSInteger)weight font: (NSInteger)font{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

+ (UILabel *)labelWithWeight: (NSInteger)weight font: (NSInteger)font text: (NSString *)text textColor: (UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    if (text.length > 0) {
        label.text = text;
        [label sizeToFit];
    }
    if (color) {
        label.textColor = color;
    }
    return label;
}

+ (void)addBorder: (UIView *)view {
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.5;
    view.layer.masksToBounds = true;
}

+ (void)addUpDownBorder: (UIView *)view {
    [view sizeToFit];
    CALayer *upLayer = [CALayer layer];
    upLayer.frame = CGRectMake(0, 0, view.bounds.size.width, 1);
    upLayer.backgroundColor = [UIColor grayColor].CGColor;
    CALayer *downLayer = [CALayer layer];
    downLayer.frame = CGRectMake(0, view.bounds.size.height - 1, view.bounds.size.width, 1);
    downLayer.backgroundColor = [UIColor grayColor].CGColor;
    [view.layer addSublayer:upLayer];
    [view.layer addSublayer:downLayer];
}

@end
