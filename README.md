# SLQuartz2D
Quartz 2D是一个二维图形绘制引擎，它支持iOS环境和Mac OS X环境，为开发者提供了很多方便，它在绘图上的功能十分强大，如基于路径的绘图、透明度、阴影、颜色管理、反锯齿、PDF文档生成等。Quartz 2D作为Core Graphics框架的一部分，其中的很多数据类型和方法都是以CG为前缀的。
# Quartz 2D绘图基本步骤
1. 获取与视图相关联的上下文对象
	UIGraphicsGetCurrentContext
2. 创建及设置路径 （path）
	2.1 创建路径
	2.2 设置路径起点
	2.3 增加路径内容……
3. 将路径添加到上下文 
4. 设置上下文状态 
边线颜色、填充颜色、线宽、线段连接样式、线段首尾样式、虚线样式…
5. 绘制路径
6. 释放路径

# Quartz 2D绘图方法
![构建路径](http://ww4.sinaimg.cn/large/987b958agw1f7jpnk7sq6j20iq0bqgq5.jpg)
![绘制路径](http://ww3.sinaimg.cn/large/987b958agw1f7jpo3y5vrj20it09h0wf.jpg)
![设置参数](http://ww2.sinaimg.cn/large/987b958agw1f7jpolmgx9j20iy072418.jpg)

# 应用场景
- 绘制图形 : 线条\三角形\矩形\圆\弧等
- 绘制文字
- 绘制\生成图片(图像)/水印图片
- 读取\生成PDF
- 截图\裁剪图片
- 自定义UI控件
- 涂鸦\画板
- 手势解锁

# 画板实例
#### 1. 创建MainViewController;
#### 2. 创建DrawView用户完成绘图的功能
	2.1 先使用touchMoved记录触摸点绘图，只能记录最后一次的点
	2.2 使用路径的方式记录所有的点，drawRect方法中绘制该路径
	2.3 调整之后，只能记录末次的路径，还需要一个数组，记录完整的绘图步骤
	2.4 创建DrawPath封装路径，以保存每一步的颜色和线宽

#### 3. 创建工具视图ToolView
	3.1 新建
	3.2 创建工具视图中的按钮
	3.3 自定义按钮实现选中按钮，在按钮下方绘制红色线条
	提示：上要使用按钮的selected属性，否则没有办法直接用setter方法

#### 4. 创建选择颜色视图SelectView
	4.1 新建
	4.2 夊制ToolView的创建按钮方法，稊作修改
	4.3 定义块代码
	4.4 扩展初始化方法initWithFrame
	4.5 在监听方法中调用块代码变量向上方传递选择的颜色
	4.6 修改ToolView中选择颜色的懒加载方法，接收颜色，并利用块代码向视图控制器传递颜色
	4.7 在视图控制器中，修改实例化工具视图的方法，接收到颜色变化消息时，修改绘图视图中使用的绘制颜色
#### 5. 创建选择线宽视图
    5.1 新建
	5.2 夊制显示、隐藏选择颜色的代码并稊加修改
	5.3 重构显示、隐藏视图部分代码，使其夊用
	...


#注意事项
- 当在UIView子类中重写drawRect:方法时，iOS会自动准备好一个图形上下文，可以通过调用UIGraphicsGetCurrentContext()来获取
- 只要一个UIView需要被刷新或者重绘，drawRect:方法就会被调用，所以drawRect:的调用频率很高
- 需要注意的是：重绘时应该调用setNeedsDisplay，而不能直接调用drawRect:，setNeedsDisplay会自动调用drawRect:
- drawRect:是在UIViewController的loadView和viewDidLoad两方法之后调用的
- 如果在UIView初始化时没有设置CGRect，drawRect:将不会被自动调用
- 如果设置UIView的contentMode属性值为UIViewContentModeRedraw，那么将在每次更改frame时自动调用drawRect:
- 如果使用UIView绘图，只能在drawRect:方法中获取相应的CGContextRef并绘图。而在其他方法中获取的CGContextRef不能用于绘图


