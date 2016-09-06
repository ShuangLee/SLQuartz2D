//
//  SLSelectButton.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLSelectButton.h"

@implementation SLSelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 如果selectedMyButton == YES在按钮的下方绘制一条红线
    if (self.selectedMyButton) {
        CGRect frame = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 2);
        [[UIColor redColor]set];
        UIRectFill(frame);
    }
}

#pragma mark - setter方法
- (void)setSelectedMyButton:(BOOL)selectedMyButton
{
    _selectedMyButton = selectedMyButton;
    
    [self setNeedsDisplay];
}

@end
