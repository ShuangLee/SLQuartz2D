//
//  SLDrawView.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDrawView : UIView
/** 线宽 */
@property (assign, nonatomic) CGFloat lineWidth;

/** 颜色 */
@property (strong, nonatomic) UIColor *drawColor;

/** 照片 */
@property (strong, nonatomic) UIImage *image;

/**
 *  撤销操作
 */
- (void)undo;

/**
 *  清屏操作
 */
- (void)clearScreen;
@end
