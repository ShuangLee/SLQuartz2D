//
//  SLWaterMaskController.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLWaterMaskController.h"
#import "UIImage+WaterMask.h"

@implementation SLWaterMaskController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"local"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[image sl_waterMaskImageWithString:@"水印么么哒～" size:self.view.bounds.size]];
    [self.view addSubview:imageView];
}
@end
