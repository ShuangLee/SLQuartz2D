//
//  SLDrawToolView.h
//  SLQuartz2D
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDrawSelectColorView.h"
#import "SLDrawSelectLineWidthView.h"

#pragma mark 工具视图的操作块代码
typedef void(^ToolViewActionBlock)();

//#pragma mark - 选择橡皮擦的块代码定义
//typedef void(^ToolViewSelectEarserBlock)();
//#pragma mark - 选择撤销操作的块代码
//typedef void(^ToolViewSelectUndoBlock)();
//#pragma mark - 选择清屏操作的块代码
//typedef void(^ToolViewSelectClearBlock) ();
//#pragma mark - 选择相机的块代码
//typedef void(^ToolViewSelectPhotoBlock) ();

@interface SLDrawToolView : UIView
// 对initWithFrame进行扩展，增加块代码参数
- (id)initWithFrame:(CGRect)frame
   afterSelectColor:(SelectColorBlock)afterSelectColor
afterSelectLineWidth:(SelectLineWidthBlock)afterSelectLineWidth
       selectEarser:(ToolViewActionBlock)selectEarser
          selectUndo:(ToolViewActionBlock)selectUndo
        selectClear:(ToolViewActionBlock)selectClear
        selectPhoto:(ToolViewActionBlock)selectPhoto;
@end
