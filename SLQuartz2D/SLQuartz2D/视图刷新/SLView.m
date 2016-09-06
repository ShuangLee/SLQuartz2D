//
//  SLView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLView.h"

@implementation SLView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 设置背景颜色
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // 2. 设置默认文本
        self.text = @"hello world!";
        
        // 3. 设置默认字号
        self.fontSize = 20.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 1. 绘制文本
    UIFont *font = [UIFont systemFontOfSize:self.fontSize];
    
    [self.text drawInRect:self.bounds withAttributes:@{NSFontAttributeName: font}];
}

#pragma mark - setter方法
- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    // 在setter方法中调用重绘
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    [self setNeedsDisplay];
}


@end
