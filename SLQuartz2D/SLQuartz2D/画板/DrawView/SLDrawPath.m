//
//  SLDrawPath.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDrawPath.h"

@implementation SLDrawPath
+ (id)drawPathWithCGPath:(CGPathRef)drawPath color:(UIColor *)color lineWidth:(CGFloat)lineWidth {
    SLDrawPath *path = [[SLDrawPath alloc] init];
    path.drawPath = [UIBezierPath bezierPathWithCGPath:drawPath];
    path.drawColor = color;
    path.lineWith = lineWidth;
    
    return path;
}
@end
