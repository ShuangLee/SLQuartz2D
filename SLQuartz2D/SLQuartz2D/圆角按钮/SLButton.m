//
//  SLButton.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLButton.h"

@implementation SLButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = [self drawRoundCornerRectForRect:rect radius:8.0];
    
    CGContextSetFillColorWithColor(context, self.defaultColor.CGColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
}

- (CGMutablePathRef)drawRoundCornerRectForRect:(CGRect)rect radius:(CGFloat)radius {
    //申请路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //将起始点移动到点0
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    //绘制曲线1
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    //绘制曲线2
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    //绘制曲线3
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    //绘制曲线4
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    //闭合path，绘制直线5
    CGPathCloseSubpath(path);
    
    return path;
}

- (void)setDefaultColor:(UIColor *)defaultColor {
    // 设置默认颜色
    _defaultColor = defaultColor;
    [self setNeedsDisplay];
}
@end
