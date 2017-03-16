//
//  GXHoldTool.h
//  GXAppNew
//
//  Created by zhudong on 2017/3/8.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GXHoldTool : NSObject

+ (UILabel *)labelWithWeight: (NSInteger)weight font: (NSInteger)font;
+ (UILabel *)labelWithWeight: (NSInteger)weight font: (NSInteger)font text: (NSString *)text textColor: (UIColor *)color;
+ (void)addBorder: (UIView *)view;
+ (void)addUpDownBorder: (UIView *)view;
@end
