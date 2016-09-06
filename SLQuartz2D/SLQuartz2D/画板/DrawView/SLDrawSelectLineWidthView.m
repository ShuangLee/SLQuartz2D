//
//  SLDrawSelectLineWidthView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDrawSelectLineWidthView.h"

static CGFloat const kButtonSpace = 10.0;
@interface SLDrawSelectLineWidthView ()
{
    SelectLineWidthBlock _selectLineWidthBlock;
}

@property (strong, nonatomic) NSArray *lineWidthArray;
@end

@implementation SLDrawSelectLineWidthView

- (id)initWithFrame:(CGRect)frame afterSelectLineWidth:(SelectLineWidthBlock)afterSeletLineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectLineWidthBlock = afterSeletLineWidth;
        
        [self setBackgroundColor:[UIColor redColor]];
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // 绘制颜色的按钮
        NSArray *array = @[@(1.0), @(3.0), @(5.0), @(8.0), @(10.0), @(15.0), @(20.0)
                           ];
        self.lineWidthArray = array;
        
        [self createLineButtonsWithArray:array];
    }
    return self;
}

#pragma mark 创建选择线宽的按钮
- (void)createLineButtonsWithArray:(NSArray *)array
{
    // 1. 计算按钮的位置
    // 2. 设置按钮的颜色，需要使用数组
    // 按钮的宽度，起始点位置
    NSInteger count = array.count;
    CGFloat width = (self.bounds.size.width - (count + 1) * kButtonSpace)/ count;
    CGFloat height = self.bounds.size.height;
    
    NSInteger index = 0;
    for (NSString *text in array) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat startX = kButtonSpace + index * (width + kButtonSpace);
        [button setFrame:CGRectMake(startX, 5, width, height - 10)];
        
        // 设置选择线宽的提示文字
        NSString *text = [NSString stringWithFormat:@"%@点", self.lineWidthArray[index]];
        [button setTitle:text forState:UIControlStateNormal];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [button setTag:index];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        index++;
    }
}

#pragma mark - 按钮监听方法
- (void)tapButton:(UIButton *)button
{
    // 把按钮对应的线宽数值作为块代码的参数，执行块代码
    _selectLineWidthBlock([self.lineWidthArray[button.tag]floatValue]);
}


@end
