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

#注意事项
- 当在UIView子类中重写drawRect:方法时，iOS会自动准备好一个图形上下文，可以通过调用UIGraphicsGetCurrentContext()来获取
- 只要一个UIView需要被刷新或者重绘，drawRect:方法就会被调用，所以drawRect:的调用频率很高
- 需要注意的是：重绘时应该调用setNeedsDisplay，而不能直接调用drawRect:，setNeedsDisplay会自动调用drawRect:
- drawRect:是在UIViewController的loadView和viewDidLoad两方法之后调用的
- 如果在UIView初始化时没有设置CGRect，drawRect:将不会被自动调用
- 如果设置UIView的contentMode属性值为UIViewContentModeRedraw，那么将在每次更改frame时自动调用drawRect:
- 如果使用UIView绘图，只能在drawRect:方法中获取相应的CGContextRef并绘图。而在其他方法中获取的CGContextRef不能用于绘图


