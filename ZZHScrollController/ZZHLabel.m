//
//  ZZHLabel.m
//  ZZHScrollController
//
//  Created by zzh on 2017/2/9.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ZZHLabel.h"
const CGFloat XMGRed = 0.4;
const CGFloat XMGGreen = 0.6;
const CGFloat XMGBlue = 0.7;
const CGFloat XMGAlpha = 1.0;
@implementation ZZHLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:XMGRed green:XMGGreen blue:XMGBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    CGFloat red = XMGRed + (1 - XMGRed) * scale;
    CGFloat green = XMGGreen + (0 - XMGGreen) * scale;
    CGFloat blue = XMGBlue + (0 - XMGBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:XMGAlpha];
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
