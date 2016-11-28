HCCycleView 一个无限循环轮播图
### 功能
- 两种创建方式：代码创建和xib创建
- 支持同时显示本地图片和网络图片
- 支持自定义PageControl样式

### 演示

![创建方式演示](https://github.com/ACoderNHC/HCCycleView/blob/master/HCCycleViewDemo/创建方式.gif)

![自定义样式演示](https://github.com/ACoderNHC/HCCycleView/blob/master/HCCycleViewDemo/自定义样式.gif)

### 使用
- 该库需要用到SDWebImage对图片进行下载缓存操作，所以需要集成SDWebImage第三方库
- 将库中的HCCycleView文件夹拖入你的文件后，在使用的地方引入“HCCycleView.h”

### 详细
- 代码创建

```objc
 // 创建视图
 HCCycleView *cycleScrollView = [HCCycleView cycleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 205) delegate:self placeholderImage:PLACEHOLDER_IMAGE];
 // 传入图片数组
 cycleScrollView.imageArrays = imageArr;
```

- xib 创建方式
  
  - 先拖入一个UIView控件

       ![拖入一个UIVIew控件.png](http://upload-images.jianshu.io/upload_images/641084-8a4389ae3f8e1b89.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 将UIView的类设置成HCCycleView
      
      ![设置UIView控件的类.png](http://upload-images.jianshu.io/upload_images/641084-2d2df7b943550903.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 将该View拖线到你要使用的控制器里

      ![引入设置好的HCCycleView-1.png](http://upload-images.jianshu.io/upload_images/641084-2604fa37de8b2f1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

      ![引入设置好的HCCycleView-2.png](http://upload-images.jianshu.io/upload_images/641084-2df4a54e15d683b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  -  传入图片数组
	```objc
 		cycleView.imageArrays = imageArr;
	```


### 自定义PageControl

```objc
/***pageControl样式，系统样式和边框样式，默认系统样式*/
@property (nonatomic,assign) HCPageControlType pageControlType;
/***pageControl水平位置,默认居中*/
@property (nonatomic,assign) HCPageControlPosition pageControlPosition;
/***pageControl的dot之间间隔大小*/
@property (nonatomic,assign) CGFloat pageControlDotInterSpace;
/***pageControl的dot的大小*/
@property (nonatomic,assign) CGSize pageControlDotSize;
/***pageControl的dot的边框宽度*/
@property (nonatomic,assign) CGFloat pageControlDotBorderWidth;
/***pageControl的自定义frame*/
@property (nonatomic,assign) CGRect pageControlCustomFrame;
/***pageControl距离底部的距离*/
@property (nonatomic,assign) CGFloat pageControlBottom;
/***pageControl的pageControlColor*/
@property (nonatomic,strong) UIColor *pageControlColor;
/***pageControl的currentPageControlColor*/
@property (nonatomic,strong) UIColor *currentPageControlColor; 
```
### 其他属性说明
```objc
/*** 自动轮播属性，默认自动轮播 */
@property (nonatomic,assign) BOOL isAutoScroll;
/*** 轮播时间间隔 */
@property (nonatomic,assign) NSTimeInterval timerInterVal;
/*** 图片占位图 */
@property (nonatomic,strong) UIImage *placeholderImage;
/*** 图片数组，支持网络图片和本地图片*/
@property (nonatomic,copy) NSArray *imageArrays;
```
### 示例代码
```objc

    // 图片数组
    NSArray *imageArr = @[@"http://image72.360doc.com/DownloadImg/2014/04/2301/40991904_7.jpg",
                          @"http://img4.duitang.com/uploads/blog/201406/28/20140628174102_R8Hhd.thumb.700_0.jpeg",
                          [UIImage imageNamed:@"local_image.jpg"],
                          @"http://uploadfile.bizhizu.cn/2014/0507/20140507103639644.jpg",
                          @"http://image55.360doc.com/DownloadImg/2012/10/2517/27773420_5.jpg",
                          @"http://pic62.nipic.com/file/20150303/17961491_092446597000_2.jpg"
                          ];
    
    HCCycleView *cycleScrollView = [HCCycleView cycleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 205) delegate:self placeholderImage:PLACEHOLDER_IMAGE];
    cycleScrollView.isAutoScroll = NO;
    cycleScrollView.currentPageControlColor = [UIColor whiteColor];
    cycleScrollView.pageControlColor = [UIColor purpleColor];
    cycleScrollView.pageControlType = HCPageControlTypeBorder;
    cycleScrollView.pageControlPosition = HCPageControlPositionRight;
    cycleScrollView.pageControlCustomFrame = CGRectMake(10, 180, 100, 20);
    cycleScrollView.pageControlDotBorderWidth = 1;
    cycleScrollView.pageControlDotInterSpace = 20;
    cycleScrollView.pageControlDotSize = CGSizeMake(10, 10);
    cycleScrollView.imageArrays = imageArr;
    [self.view addSubview:cycleScrollView];
```

