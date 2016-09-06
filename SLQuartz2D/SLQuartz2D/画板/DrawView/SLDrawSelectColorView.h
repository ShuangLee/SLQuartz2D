//
//  SLDrawSelectColorView.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 定义块代码
typedef void(^SelectColorBlock)(UIColor *color);

@interface SLDrawSelectColorView : UIView
// 扩展initWithFrame方法，增加块代码参数
// 该块代码，将在选择颜色按钮之后执行
- (id)initWithFrame:(CGRect)frame afterSelectColor:(SelectColorBlock)afterSelectColor;
@end
