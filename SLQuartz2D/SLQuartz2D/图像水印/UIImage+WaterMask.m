//
//  UIImage+WaterMask.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "UIImage+WaterMask.h"

@implementation UIImage (WaterMask)
#pragma mark - 增加图像的水印
// 生成一张新的图片 => 原始图片 + 水印文字
- (UIImage *)sl_waterMaskImageWithString:(NSString *)string size:(CGSize)size {
    // 1. 建立图像的上下文，需要指定新生成的图像大小
    UIGraphicsBeginImageContext(size);
    
    // 2. 绘制内容
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
//    // 绘制矩形--添加水印矩形
//    [[UIColor yellowColor] set];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddRect(context, CGRectMake(50, 50, 100, 100));
//    CGContextDrawPath(context, kCGPathEOFill);
    
    // 3. 添加水印
    [string drawInRect:CGRectMake(0, size.height - 30, size.width - 20, 30) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20],NSForegroundColorAttributeName: [UIColor redColor]}];
    
    // 4. 获取到新生成的图像，从当前上下文获取到新绘制的图像
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5. 关闭图像上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
