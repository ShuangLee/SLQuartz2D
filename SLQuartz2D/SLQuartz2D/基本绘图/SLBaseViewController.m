//
//  SLBaseViewController.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLBaseViewController.h"
#import "SLBaseView.h"

@interface SLBaseViewController ()

@end

@implementation SLBaseViewController

- (void)loadView {
    self.view = [[SLBaseView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
