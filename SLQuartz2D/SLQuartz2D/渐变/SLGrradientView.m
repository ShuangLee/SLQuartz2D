//
//  SLGrradientView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLGrradientView.h"

@implementation SLGrradientView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawGradient2:context];
}

#pragma mark - 绘制渐变
#pragma mark 径向渐变
- (void)drawGradient2:(CGContextRef)context {
    // 绘制渐变
    // 在计算机设计中，直接选择RGB即可，其他的颜色空间暂时不用考虑
    // 1. 创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 2. 创建渐变
    /**
     参数说明：
     
     1. colorSpace 颜色空间 rgb
     2. components 数组，每4个一组，表示一个颜色 {r, g, b, a, r, g, b, a}
     3. location 表示渐变开始的位置
     */
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    CGFloat locations[2] = {0.3, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    // 渐变的区域剪裁
    /*
     提示：整个渐变实际上是完整绘制在屏幕上的，通过裁剪区域，可以让指定范围内显示渐变效果
     */
    // 3. 设置裁剪区域范围
    
    
    // 4. 绘制渐变
    /*
     1) context
     2) gradient
     3) startCenter 起始中心点
     4） startRadius 起始半径，如果指定为0，就从圆心开始渐变，否则，会空出指定半径的位置，不填充
     5） endCenter 截止点(通常和起始中心点重合，即便偏移，也不会太大)
     6） endRadius 截止半径
     7） 渐变填充方式
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 230), 10, CGPointMake(0, 0), 150, kCGGradientDrawsAfterEndLocation);
    
    // 5. 释放对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

#pragma mark 线性渐变
- (void)drawGradient:(CGContextRef)context {
    // 绘制渐变
    // 在计算机设计中，直接选择RGB即可，其他的颜色空间暂时不用考虑
    // 1. 创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 2. 创建渐变
    /**
     参数说明：
     
     1. colorSpace 颜色空间 rgb
     2. components 数组，每4个一组，表示一个颜色 {r, g, b, a, r, g, b, a}
     3. location 表示渐变开始的位置
     */
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    CGFloat locations[2] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    // 渐变的区域剪裁
    /*
     提示：整个渐变实际上是完整绘制在屏幕上的，通过裁剪区域，可以让指定范围内显示渐变效果
     */
    //    CGContextClipToRect(context, CGRectMake(0, 360, 200, 100));
    // 3. 设置裁剪区域范围
    CGRect rects[5] = {CGRectMake(0, 0, 100, 100),
        CGRectMake(200, 0, 100, 100),
        CGRectMake(100, 100, 100, 100),
        CGRectMake(200, 200, 100, 100),
        CGRectMake(0, 200, 100, 100)};
    
    CGContextClipToRects(context, rects, 5);
    
    // 4. 绘制渐变
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0), CGPointMake(320.0, 460.0), kCGGradientDrawsAfterEndLocation);
    
    // 5. 释放对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}
@end
