//
//  SLDrawSelectLineWidthView.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 定义块代码
typedef void(^SelectLineWidthBlock)(CGFloat lineWidth);

@interface SLDrawSelectLineWidthView : UIView
#pragma mark 扩展初始化方法，增加块代码
- (id)initWithFrame:(CGRect)frame afterSelectLineWidth:(SelectLineWidthBlock)afterSeletLineWidth;
@end
