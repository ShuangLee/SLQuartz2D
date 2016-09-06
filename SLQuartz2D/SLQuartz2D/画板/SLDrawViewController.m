//
//  SLDrawViewController.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDrawViewController.h"
#import "SLDrawView.h"
#import "SLDrawToolView.h"

@interface SLDrawViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) SLDrawView *drawView;
@end

@implementation SLDrawViewController

#pragma mark - 实例化视图
- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];;
    
    SLDrawView *drawView = [[SLDrawView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    SLDrawToolView *toolView = [[SLDrawToolView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44) afterSelectColor:^(UIColor *color) {
        // 给绘图视图设置颜色
        [drawView setDrawColor:color];
    } afterSelectLineWidth:^(CGFloat lineWidth) {
        // 工具视图选择线宽之后，需要执行的代码
        [drawView setLineWidth:lineWidth];
    } selectEarser:^{
        [drawView setDrawColor:[UIColor whiteColor]];
        [drawView setLineWidth:30.0];
    } selectUndo:^{
        [drawView undo];
    } selectClear:^{
        [drawView clearScreen];
    } selectPhoto:^{
        // 弹出图像选择窗口，来选择照片
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        // 1. 设置照片源
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        // 2. 设置代理
        [picker setDelegate:self];
        
        // 3. 显示
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    [self.view addSubview:toolView];
}

#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    // 设置绘图视图
    [self.drawView setImage:image];
    
    // 关闭照片选择窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
