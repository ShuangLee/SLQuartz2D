//
//  SLView.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLView : UIView
// 1. 文本
@property (copy, nonatomic) NSString *text;

// 2. 字体大小
@property (assign, nonatomic) CGFloat fontSize;
@end
