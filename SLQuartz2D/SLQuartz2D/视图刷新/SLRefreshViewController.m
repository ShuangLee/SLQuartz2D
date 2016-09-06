//
//  SLRefreshViewController.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLRefreshViewController.h"
#import "SLView.h"

@interface SLRefreshViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) SLView *myView;
@end

@implementation SLRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. SLView
    SLView *myView = [[SLView alloc]initWithFrame:CGRectMake(0, 70, 320, 200)];
    [self.view addSubview:myView];
    self.myView = myView;
    
    // 2. UITextField
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 280, 280, 30)];
    // 1) 边框
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    // 2) 文本的垂直对齐方式
    [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    // 3) 设置文本框的代理
    [textField setDelegate:self];
    
    [self.view addSubview:textField];

    
    // 3. 滑块
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 320, 280, 20)];
    // 1) 最小值
    [slider setMinimumValue:10.0];
    // 2) 最大值
    [slider setMaximumValue:40.0];
    // 3) 当前值
    [slider setValue:20.0];
    
    // 4) 监听方法
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

#pragma mark - 滑块的监听方法
- (void)sliderValueChanged:(UISlider *)slider
{
    // 跟踪滑块的数值变化情况
    NSLog(@"%f", slider.value);
    
    [self.myView setFontSize:slider.value];
    
    //    // 使用NeedDisplay 让myView重新绘制
    //    [self.myView setNeedsDisplay];//放入set方法中调用
}

#pragma mark - 文本框代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.myView setText:textField.text];
    
    return YES;
}


@end
