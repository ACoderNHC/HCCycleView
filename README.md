# HCCycleView 一个无限循环轮播图
支持网络图片和本地图片展示。
支持代码创建和xib创建
### 使用方法
该库需要用到SDWebImage对图片进行下载缓存操作，所以需要集成SDWebImage第三方库
将库中的HCCycleView文件夹拖入你的文件后即可使用
在使用的地方引入“HCCycleView.h”
- 代码创建方式

```objc
 HCCycleView *cycleScrollView = [HCCycleView cycleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 205) delegate:self placeholderImage:PLACEHOLDER_IMAGE];

```

- xib 创建方式

    - 先拖入一个UIView控件
        
        ![拖入一个UIVIew控件.png](http://upload-images.jianshu.io/upload_images/641084-8a4389ae3f8e1b89.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

    - 将UIView的类设置成HCCycleView

        ![设置UIView控件的类.png](http://upload-images.jianshu.io/upload_images/641084-2d2df7b943550903.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

    - 将该View拖线到你要使用的控制器里

        ![引入设置好的HCCycleView-1.png](http://upload-images.jianshu.io/upload_images/641084-2604fa37de8b2f1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

        ![引入设置好的HCCycleView-2.png](http://upload-images.jianshu.io/upload_images/641084-2df4a54e15d683b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 部分属性和方法说明

```objc
// 是否自动轮播
@property (nonatomic,assign) BOOL isAutoScroll;
// 自动轮播的时间间隔
@property (nonatomic,assign) NSTimeInterval timerInterVal;
// 图片占位图
@property (nonatomic,strong) UIImage *placeholderImage;
/*** 图片数组 */
@property (nonatomic,copy) NSArray *imageArrays;

// pageControl类型
@property (nonatomic,assign) HCPageControlType pageControlType;
// pageControl的显示位置
@property (nonatomic,assign) HCPageControlPosition pageControlPosition;
// pageControl的dot之间间隔大小
@property (nonatomic,assign) CGFloat pageControlDotInterSpace;
// pageControl的dot的大小
@property (nonatomic,assign) CGSize pageControlDotSize;
// pageControl的dot的边框宽度
@property (nonatomic,assign) CGFloat pageControlDotBorderWidth;
// pageControl的自定义frame
@property (nonatomic,assign) CGRect pageControlCustomFrame;
// pageControl距离底部的距离
@property (nonatomic,assign) CGFloat pageControlBottom;
// pageControl的pageControlColor
@property (nonatomic,strong) UIColor *pageControlColor;
// pageControl的currentPageControlColor
@property (nonatomic,strong) UIColor *currentPageControlColor;

/*** 推荐初始化方法 */
+ (instancetype)cycleViewWithFrame:(CGRect)frame delegate:(id <HCCycleViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/*** 点击图片Block */
@property (nonatomic,copy) void (^didClickPicture)(NSInteger);

/*** 滚动到某一页方法 (从0开始算起) */
- (void)scrollToIndex:(NSInteger)index animate:(BOOL)animate;
```

### 具体使用代码
#### 代码创建
```objc

 // 图片 本地图片和网络图片均支持
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
//    cycleScrollView.pageControlPosition = HCPageControlPositionRight;
    cycleScrollView.pageControlCustomFrame = CGRectMake(10, 180, 100, 20);
    cycleScrollView.pageControlDotBorderWidth = 1;
    cycleScrollView.pageControlDotInterSpace = 20;
    cycleScrollView.pageControlDotSize = CGSizeMake(10, 10);
    cycleScrollView.imageArrays = imageArr;
    [self.view addSubview:cycleScrollView];
```

#### xib创建
```objc
    // 图片 本地图片和网络图片均支持
    NSArray *imageArr = @[@"http://image72.360doc.com/DownloadImg/2014/04/2301/40991904_7.jpg",
                          @"http://img4.duitang.com/uploads/blog/201406/28/20140628174102_R8Hhd.thumb.700_0.jpeg",
                          [UIImage imageNamed:@"local_image.jpg"],
                          @"http://uploadfile.bizhizu.cn/2014/0507/20140507103639644.jpg",
                          @"http://image55.360doc.com/DownloadImg/2012/10/2517/27773420_5.jpg",
                          @"http://pic62.nipic.com/file/20150303/17961491_092446597000_2.jpg"
                          ];

    // xib创建
    self.cycleView.isAutoScroll = YES;
    self.cycleView.delegate = self;
    self.cycleView.timerInterVal = 5;
    self.cycleView.placeholderImage = PLACEHOLDER_IMAGE;
    self.cycleView.pageControlType = HCPageControlTypeNone;
    self.cycleView.currentPageControlColor = [UIColor whiteColor];
    self.cycleView.pageControlColor = [UIColor purpleColor];
    self.cycleView.pageControlPosition = HCPageControlPositionMiddle;
    self.cycleView.imageArrays = imageArr;
```

#### 演示

![demo.gif](https://github.com/ACoderNHC/HCCycleView/blob/master/HCCycleViewDemo/demo.gif)

