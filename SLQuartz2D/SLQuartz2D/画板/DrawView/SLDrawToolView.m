//
//  SLDrawToolView.m
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDrawToolView.h"
#import "SLSelectButton.h"

// 按钮的间距
static CGFloat const kButtonSpace = 10.0;

// 注意，枚举的顺序需要和按钮文字数组中的顺序保持一致
typedef enum
{
    kButtonColor = 0,
    kButtonLineWidth,
    kButtonEarser,
    kButtonUndo,
    kButtonClearScreen,
    kButtonCamera,
    kButtonSave
} kButtonActionType;

@interface SLDrawToolView ()
{
    SelectColorBlock _selectColorBlock;
    SelectLineWidthBlock _selectLineWidthBlock;
    ToolViewActionBlock _selectEarserBlock;
    ToolViewActionBlock _selectUndoBlock;
    ToolViewActionBlock _selectClearBlock;
    ToolViewActionBlock _selectPhotoBlock;
}

// 当前用户选中的按钮
@property (weak, nonatomic) SLSelectButton *selectButton;
// 选择颜色视图
@property (weak, nonatomic) SLDrawSelectColorView *colorView;
// 选择线宽视图
@property (weak, nonatomic) SLDrawSelectLineWidthView *lineWidthView;
@end

@implementation SLDrawToolView

- (id)initWithFrame:(CGRect)frame
   afterSelectColor:(SelectColorBlock)afterSelectColor
afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth
       selectEarser:(ToolViewActionBlock)selectEarser
          selectUndo:(ToolViewActionBlock)selectUndo
        selectClear:(ToolViewActionBlock)selectClear
        selectPhoto:(ToolViewActionBlock)selectPhoto
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _selectColorBlock = afterSelectColor;
        _selectLineWidthBlock = afterSelectLineWidth;
        _selectEarserBlock = selectEarser;
        _selectUndoBlock = selectUndo;
        _selectClearBlock = selectClear;
        _selectPhotoBlock = selectPhoto;
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // 通过循环的方式创建按钮
        NSArray *array = @[@"颜色", @"线宽", @"橡皮", @"撤销", @"清屏", @"相机", @"保存"];
        
        [self createButtonsWithArray:array];
    }
    
    return self;
}

#pragma mark 创建工具视图中的按钮
- (void)createButtonsWithArray:(NSArray *)array
{
    // 按钮的宽度，起始点位置
    NSInteger count = array.count;
    CGFloat width = (self.bounds.size.width - (count + 1) * kButtonSpace)/ count;
    CGFloat height = self.bounds.size.height;
    
    NSInteger index = 0;
    for (NSString *text in array) {
        SLSelectButton *button = [SLSelectButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat startX = kButtonSpace + index * (width + kButtonSpace);
        [button setFrame:CGRectMake(startX, 8, width, height - 16)];
        
        [button setTitle:text forState:UIControlStateNormal];
        [button setTag:index];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        // 测试代码
        //        [button setSelectedMyButton:YES];
        
        index++;
    }
}

#pragma mark 按钮监听方法
- (void)tapButton:(SLSelectButton *)button
{
    // 方法1：遍历所有的按钮，将selectedMyButton设置为NO，取消所有的下方红线
    // 方法2：在属性中记录前一次选中的按钮，将该按钮的属性设置为NO
    if (self.selectButton != nil && self.selectButton != button) {
        [self.selectButton setSelectedMyButton:NO];
    }
    // 通过设置当前按钮selectedMyButton属性，在下方绘制红线
    [button setSelectedMyButton:YES];
    self.selectButton = button;
    
    switch (button.tag) {
        case kButtonColor:
            // 点击按钮的时候强行关闭当前显示的子视图
            [self forceHideView:self.colorView];
            
            // 显示/隐藏颜色选择视图
            [self showHideColorView];
            
            break;
        case kButtonLineWidth:
            // 点击按钮的时候强行关闭当前显示的子视图
            [self forceHideView:self.lineWidthView];
            
            // 显示/隐藏选择线宽视图
            [self showHideLineWidthView];
            
            break;
        case kButtonEarser:
            // 以变量的方式调用视图控制器的块代码
            _selectEarserBlock();
            
            [self forceHideView:nil];
            
            break;
        case kButtonUndo:
            _selectUndoBlock();
            
            [self forceHideView:nil];
            
            break;
        case kButtonClearScreen:
            _selectClearBlock();
            
            [self forceHideView:nil];
            
            break;
        case kButtonCamera:
            _selectPhotoBlock();
            
            [self forceHideView:nil];
            
            break;
        default:
            break;
    }
}

#pragma mark - 子视图操作方法
#pragma mark 强行隐藏当前显示的子视图
// 如果显示的视图与传入的比较视图相同，就不再关闭
- (void)forceHideView:(UIView *)compareView
{
    // 1. 用属性记录当前显示的子视图，强行关闭该视图即可
    // 2. 遍历所有子视图，如果处于显示状态，则将其关闭
    // 3. 直接判断子视图，此方法仅适用于子数图数量极少
    UIView *view = nil;
    if (self.colorView.frame.origin.y > 0) {
        view = self.colorView;
    } else if (self.lineWidthView.frame.origin.y > 0) {
        view = self.lineWidthView;
    } else {
        return;
    }
    
    if (view == compareView) {
        return;
    }
    
    CGRect toFrame = view.frame;
    CGRect toolFrame = self.frame;
    
    toFrame.origin.y = -44;
    toolFrame.size.height = 44;
    
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:toolFrame];
        [view setFrame:toFrame];
    }];
}

#pragma mark 显示隐藏指定视图
- (void)showHideView:(UIView *)view
{
    // 2. 动画显示颜色视图
    CGRect toFrame = view.frame;
    // 工具条视图边框
    CGRect toolFrame = self.frame;
    if (toFrame.origin.y < 0) {
        // 隐藏的我们显示
        toFrame.origin.y = 44;
        toolFrame.size.height = 88;
    } else {
        toFrame.origin.y = -44;
        toolFrame.size.height = 44;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:toolFrame];
        [view setFrame:toFrame];
    }];
}

#pragma mark 显示隐藏选择线宽视图
- (void)showHideLineWidthView
{
    // 1. 懒加载选择线宽视图
    if (self.lineWidthView == nil) {
        SLDrawSelectLineWidthView *view = [[SLDrawSelectLineWidthView alloc]initWithFrame:CGRectMake(0, -44, [UIScreen mainScreen].bounds.size.width, 44) afterSelectLineWidth:^(CGFloat lineWidth) {
            
            NSLog(@"%f", lineWidth);
            
            _selectLineWidthBlock(lineWidth);
            
            // 强行关闭线宽选择子视图
            [self forceHideView:nil];
        }];
        
        [self addSubview:view];
        
        self.lineWidthView = view;
    }
    
    [self showHideView:self.lineWidthView];
}

#pragma mark 显示隐藏颜色视图
- (void)showHideColorView
{
    // 1. 懒加载颜色视图
    if (self.colorView == nil) {
        SLDrawSelectColorView *view = [[SLDrawSelectColorView alloc]initWithFrame:CGRectMake(0, -44, [UIScreen mainScreen].bounds.size.width, 44) afterSelectColor:^(UIColor *color) {
            
            // 以函数的方式调用块代码变量
            _selectColorBlock(color);
            
            // 选中颜色后，强行关闭颜色选择子视图
            [self forceHideView:nil];
            
            NSLog(@"aaah");
        }];
        
        [self addSubview:view];
        
        self.colorView = view;
    }
    
    [self showHideView:self.colorView];
}

@end
