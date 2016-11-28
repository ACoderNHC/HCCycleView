//
//  HCDefaultModeViewController.m
//  HCCycleViewDemo
//
//  Created by HC on 2016/11/1.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "HCNormalViewController.h"
#import "HCCycleView.h"

@interface HCNormalViewController () <HCCycleViewDelegate>
@property (weak, nonatomic) IBOutlet HCCycleView *xibCycleView;

@end

@implementation HCNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建方式";
    
    // 图片数组
    NSArray *imageArr = @[@"http://image72.360doc.com/DownloadImg/2014/04/2301/40991904_7.jpg",
                          @"http://img4.duitang.com/uploads/blog/201406/28/20140628174102_R8Hhd.thumb.700_0.jpeg",
                          [UIImage imageNamed:@"local_image.jpg"],
                          @"http://uploadfile.bizhizu.cn/2014/0507/20140507103639644.jpg",
                          @"http://image55.360doc.com/DownloadImg/2012/10/2517/27773420_5.jpg",
                          @"http://pic62.nipic.com/file/20150303/17961491_092446597000_2.jpg"
                          ];
    
    // xib创建
    self.xibCycleView.delegate = self;
    self.xibCycleView.isAutoScroll = NO;
    self.xibCycleView.imageArrays = imageArr;
    
    // 代码创建
    HCCycleView *frameCycleView = [HCCycleView cycleViewWithFrame:CGRectMake(0, 64 + 205 + 30 + 10, SCREEN_WIDTH, 205) imageArray:imageArr placeholderImage:PLACEHOLDER_IMAGE];
    // 设置代理
    frameCycleView.delegate = self;
    // 设置轮播时间
    frameCycleView.timerInterVal = 7;
    // 添加轮播图
    [self.view addSubview:frameCycleView];
    
    // 说明Tips
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(frameCycleView.frame) + 5, SCREEN_WIDTH, 20)];
    label.text = @"代码创建";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

}

#pragma mark - HCCycleViewDelegate

- (void)cycleView:(HCCycleView *)cycleView didClickPictureIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张",index+1);
}


@end
