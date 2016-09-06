//
//  SLBaseView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLBaseView.h"

@implementation SLBaseView

- (void)drawRect:(CGRect)rect {
    // 1. 取出绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 绘制
    // 2.1 绘制图片
    [self drawImage:context];
    
    // 2.2 绘制中文文字
    [self drawChineseText:context];
    
    // 2.3 绘制英文
    [self drawText:context];
    
    // 2.4 绘制圆弧
    [self drawArc:context];
    
    // 2.5 绘圆形
    [self drawShapeCircle];
    
    // 2.6 划线
    [self drawLine2];
}

#pragma mark - 绘图方法
#pragma mark 绘制图像
- (void)drawImage:(CGContextRef)context {
    UIImage *image = [UIImage imageNamed:@"userIcon"];
    
    // 1.在指定点绘制图像
    [image drawAtPoint:CGPointMake(0, 50)];
    
    // 2. 会在指定的矩形中拉伸绘制
    //[image drawInRect:self.bounds];
    
    // 3. 在指定矩形区域中平铺图片
    //[image drawAsPatternInRect:self.bounds];
}

#pragma mark - 绘制文字(中文竖排)
- (void)drawChineseText:(CGContextRef)context {
    NSString *str = @"人生得意须尽欢，莫使金樽空对月";
    // 获取字体
    NSLog(@"%@", [UIFont familyNames]);
    UIFont *font = [UIFont fontWithName:@"Marker Felt" size:20];
    
    // 1.在指定点绘制
    //[str drawAtPoint:CGPointMake(50, 300) withAttributes:@{NSFontAttributeName: font}];
    
    // 如果在UILabel中，可以将numbersOfLine设置为0，并且指定足够的高度即可
    CGRect rect = CGRectMake(50, 300, 30, 350);
    [[UIColor lightGrayColor] set];
    UIRectFill(rect);
    
    // 2. 在指定区域绘制 中文竖排文字
    [str drawInRect:rect withAttributes:@{NSFontAttributeName: font}];
}

#pragma mark 绘制文字
- (void)drawText:(CGContextRef)context {
    NSString *str = @"Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world ";
    
    UIFont *font = [UIFont fontWithName:@"Marker Felt" size:20];
    
    // 1.在指定点绘制字符串
    [str drawAtPoint:CGPointMake(0, 280) withAttributes:@{NSFontAttributeName: font}];
    
    // 如果在UILabel中，可以将numbersOfLine设置为0，并且指定足够的高度即可
    CGRect rect = CGRectMake(100, 350, 210, 200);
    [[UIColor lightGrayColor]set];
    UIRectFill(rect);
    
    // 2.在指定区域绘制
    [str drawInRect:rect withAttributes:@{NSFontAttributeName: font}];
}

#pragma mark - 绘制圆弧
- (void)drawArc:(CGContextRef)context {
    // 1. 设置路径
    /**
     1) context 上下文
     2) x,y 是圆弧所在圆的中心点坐标
     3) radius 半径，所在圆的半径
     4) startAngle endAngle 起始角度和截止角度 单位是弧度
     0度 对应是圆的最右侧点
     5) clockwise 顺时针 0 或者逆时针 1
     */
    CGContextAddArc(context, 200, 100, 80, -M_PI_4, M_PI_4, 0);
    
    [[UIColor redColor] set];
    
    // 2. 绘制圆弧
    CGContextDrawPath(context, kCGPathFill);
}

#pragma mark - 绘制圆形
- (void)drawShapeCircle {
    // 1. 取出上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(200, 180, 150, 100);
    
    // 2. 设置路径
    [[UIColor cyanColor] set];
    UIRectFrame(rect);
    CGContextAddEllipseInRect(context, rect);
    
    // 3. 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - 绘制直线
- (void)drawLine {
    // 1. 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 设置当前上下文的路径
    // 1) 设置起始点
    CGContextMoveToPoint(context, 50, 50);
    // 2) 增加点
    CGContextAddLineToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 50, 200);
    // 3) 关闭路径
    CGContextClosePath(context);
    
    // 3 设置属性
    /*
     UIKit默认会导入Core Graphics框架，UIKit对常用的很多CG方法做了封装
     UIColor setStroke  设置边线颜色
     UIColor setFill    设置填充颜色
     UIColor set        设置边线和填充颜色
     */
    // 设置边线
    //    [[UIColor redColor]setStroke];
    // 设置填充
    //    [[UIColor blueColor]setFill];
    // 设置边线和填充
    [[UIColor greenColor]set];
    
    // 4 绘制路径，虽然没有直接定义路径，但是第2步操作，就是为上下文指定路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - 绘制直线
- (void)drawLine2
{
    // 1. 获取上下文-UIView对应的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 创建可变的路径并设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 划线->
    // 1) 设置起始点
    CGPathMoveToPoint(path, NULL, 50, 50);
    // 2) 设置目标点
    CGPathAddLineToPoint(path, NULL, 200, 200);
    CGPathAddLineToPoint(path, NULL, 50, 200);
    
    // 3) 封闭路径
    // a) 直接指定目标点
    //    CGPathAddLineToPoint(path, NULL, 50, 50);
    // b) 使用关闭路径方法
    CGPathCloseSubpath(path);
    
    // 3. 将路径添加到上下文
    CGContextAddPath(context, path);
    
    // 4. 设置上下文属性
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    
    // 设置线条宽度
    CGContextSetLineWidth(context, 5.0);
    // 设置线条的顶点样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 设置线条的连接点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 设置线条的虚线样式
    /**
     虚线的参数
     context
     phase 相位，虚线起始的位置，通常使用0即可，从头开始画虚线
     lengths 长度的数组
     count lengths数组的个数
     */
    CGFloat lengths[2] = {20.0, 10.0};
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    // 5. 绘制路径
    /**
     kCGPathStroke: 画线（空心）
     kCGPathFill:   填充（实心）
     kCGPathFillStroke: 即画线又填充
     */
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 6. 释放路径
    CGPathRelease(path);
}
@end
