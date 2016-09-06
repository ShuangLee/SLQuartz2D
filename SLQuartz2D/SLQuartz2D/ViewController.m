//
//  ViewController.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "ViewController.h"
#import "SLWaterMaskController.h"
#import "SLBaseViewController.h"
#import "SLStarViewController.h"
#import "SLGradientViewController.h"
#import "SLRoundViewController.h"
#import "SLPAFViewController.h"
#import "SLRefreshViewController.h"


static NSString * const AppleItemsIdentifier =@"ItemsIdentifier";
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
- (NSArray *)titles {
    return @[@"基本绘图",@"五角星⭐️",@"图像水印",@"渐变",@"圆角按钮",@"PDF文件",@"视图刷新"];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AppleItemsIdentifier];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Quartz 2D";
    [self.view addSubview:self.tableView];

    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppleItemsIdentifier];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[SLBaseViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[SLStarViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[SLWaterMaskController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[SLGradientViewController alloc] init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[SLRoundViewController alloc] init] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[[SLPAFViewController alloc] init] animated:YES];
            break;
        case 6:
            [self.navigationController pushViewController:[[SLRefreshViewController alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
}


@end
