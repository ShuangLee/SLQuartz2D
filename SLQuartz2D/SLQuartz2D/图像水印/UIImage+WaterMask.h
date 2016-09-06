//
//  UIImage+WaterMask.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterMask)
- (UIImage *)sl_waterMaskImageWithString:(NSString *)string size:(CGSize)size;
@end
