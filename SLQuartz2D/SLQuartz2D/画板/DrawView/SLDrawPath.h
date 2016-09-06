//
//  SLDrawPath.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SLDrawPath : NSObject
+ (id)drawPathWithCGPath:(CGPathRef)drawPath
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth;

@property (strong, nonatomic) UIBezierPath *drawPath;
@property (strong, nonatomic) UIColor *drawColor;
@property (assign, nonatomic) CGFloat lineWith;

// 用户选择的图像
@property (strong, nonatomic) UIImage *image;
@end
