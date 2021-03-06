//
//  SLDrawView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDrawView.h"
#import "SLDrawPath.h"

@interface SLDrawView ()
// 当前的绘图路径
@property (assign, nonatomic) CGMutablePathRef drawPath;
// 绘图路径数组
@property (strong, nonatomic) NSMutableArray *drawPathArray;

// 标示路径是否被释放
@property (assign, nonatomic) BOOL pathReleased;
@end

@implementation SLDrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //  设置属性的初始化
        self.lineWidth = 5.0;
        self.drawColor = [UIColor blackColor];
    }
    
    return self;
}

#pragma mark - 绘制视图
// 注意：drawRect方法每次都是完整的绘制视图中需要绘制部分的内容
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
}

#pragma mark 绘图视图内容的方法
- (void)drawView:(CGContextRef)context {
    // 首先将绘图数组中的路径全部绘制出来
    // 首先将绘图数组中的路径全部绘制出来
    for (SLDrawPath *path in self.drawPathArray) {
        if (path.image == nil) {
            CGContextAddPath(context, path.drawPath.CGPath);
            
            [path.drawColor set];
            CGContextSetLineWidth(context, path.lineWith);
            
            CGContextSetLineCap(context, kCGLineCapRound);
            
            CGContextDrawPath(context, kCGPathStroke);
        } else {
            // 有图像，没路径
            //            CGContextDrawImage(context, self.bounds, path.image.CGImage);
            [path.image drawInRect:self.bounds];
        }
    }
    
    //--------------------------------------------------------
    // 以下代码绘制当前路径的内容，就是手指还没有离开屏幕
    // 内存管理部分提到，所有create创建的都要release，而不能设置成NULL
    if (!self.pathReleased) {
        // 1. 添加路径
        CGContextAddPath(context, self.drawPath);
        
        // 2. 设置上下文属性
        [self.drawColor set];
        CGContextSetLineWidth(context, self.lineWidth);
        
        CGContextSetLineCap(context, kCGLineCapRound);
        
        // 3. 绘制路径
        CGContextDrawPath(context, kCGPathStroke);
    }
}

#pragma mark - 触摸事件
#pragma mark 触摸开始，创建绘图路径
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    self.drawPath = CGPathCreateMutable();
    
    // 记录路径没有被释放
    self.pathReleased = NO;
    
    // 在路径中记录触摸的初始点
    CGPathMoveToPoint(self.drawPath, NULL, location.x, location.y);
}

#pragma mark 移动过程中，将触摸点不断添加到绘图路径
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 可以获取到用户当前触摸的点
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    // 将触摸点添加至路径
    CGPathAddLineToPoint(self.drawPath, NULL, location.x, location.y);
    
    [self setNeedsDisplay];
}

#pragma mark 触摸结束，释放路径
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 一笔画完之后，将完整的路径添加到路径数组之中
    // 使用数组的懒加载
    if (self.drawPathArray == nil) {
        self.drawPathArray = [NSMutableArray array];
    }
    
    // 要将CGPathRef添加到NSArray之中，需要借助贝塞尔曲线对象
    // 贝塞尔曲线是UIKit对CGPathRef的一个封装，贝塞尔路径的对象可以直接添加到数组
    //    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.drawPath];
    SLDrawPath *path = [SLDrawPath drawPathWithCGPath:self.drawPath color:self.drawColor lineWidth:self.lineWidth];
    
    // 需要记录当前绘制路径的颜色和线宽
    [self.drawPathArray addObject:path];
    
    CGPathRelease(self.drawPath);
    
    // 标示路径已经被释放
    self.pathReleased = YES;
    
    // 测试线宽的代码
    //    self.lineWidth = arc4random() % 20 + 1.0;
}

#pragma mark - 工具视图执行方法
- (void)undo
{
    // 在执行撤销操作时，当前没有绘图路径
    // 要做撤销操作，需要把路径数组中的最后一条路径删除
    [self.drawPathArray removeLastObject];
    
    [self setNeedsDisplay];
}

#pragma mark - 清屏操作
- (void)clearScreen
{
    // 在执行清屏操作时，当前没有绘图路径
    // 要做清屏操作，只要把路径数组清空即可
    [self.drawPathArray removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark - image 的 setter方法
- (void)setImage:(UIImage *)image
{
    /*
     目前绘图的方法：
     
     1> 用self.drawPathArray记录已经完成（抬起手指）的路径
     2> 用self.drawPath记录当前正在拖动中的路径
     
     绘制时，首先绘制self.drawPathArray，然后再绘制self.drawPath
     
     image 传入时，drawPath没有被创建（被release但不是NULL）
     
     如果
     1> 我们将image也添加到self.drawPathArray（SLDrawPath）
     2> 在绘图时，根据是否存在image判断是绘制路径还是图像
     
     就可以实现用一个路径数组即绘制路径，又绘制图像的目的
     
     之所以要用一个数组，是因为绘图是有顺序的
     
     接下来，首先需要扩充SLDrawPath，使其支持image
     */
    // 1. 实例化一个新的DrawPath
    SLDrawPath *path = [[SLDrawPath alloc]init];
    [path setImage:image];
    
    // 2. 将其添加到self.drawPathArray，数组是懒加载的
    if (self.drawPathArray == nil) {
        self.drawPathArray = [NSMutableArray array];
    }
    [self.drawPathArray addObject:path];
    
    // 3. 重绘
    [self setNeedsDisplay];
}
@end
