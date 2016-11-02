//
//  HCCustomModeViewController.m
//  HCCycleViewDemo
//
//  Created by HC on 2016/11/1.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "HCCustomModeViewController.h"
#import "HCCycleView.h"

@interface HCCustomModeViewController () <HCCycleViewDelegate>

@end

@implementation HCCustomModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"自定义样式";
    
    // 图片 本地图片和网络图片均支持
    NSArray *imageArr = @[@"http://image72.360doc.com/DownloadImg/2014/04/2301/40991904_7.jpg",
                          @"http://img4.duitang.com/uploads/blog/201406/28/20140628174102_R8Hhd.thumb.700_0.jpeg",
                          [UIImage imageNamed:@"local_image.jpg"],
                          @"http://uploadfile.bizhizu.cn/2014/0507/20140507103639644.jpg",
                          @"http://image55.360doc.com/DownloadImg/2012/10/2517/27773420_5.jpg",
                          @"http://pic62.nipic.com/file/20150303/17961491_092446597000_2.jpg"
                          ];
    
    
    // 代码创建
    HCCycleView *cycleScrollView = [HCCycleView cycleViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 205) delegate:self placeholderImage:PLACEHOLDER_IMAGE];
    cycleScrollView.isAutoScroll = NO;
    cycleScrollView.currentPageControlColor = [UIColor whiteColor];
    cycleScrollView.pageControlColor = [UIColor purpleColor];
    cycleScrollView.pageControlType = HCPageControlTypeBorder;
//    cycleScrollView.pageControlPosition = HCPageControlPositionRight;
    cycleScrollView.pageControlCustomFrame = CGRectMake(10, 180, 100, 20);
    cycleScrollView.pageControlDotBorderWidth = 1;
    cycleScrollView.pageControlDotInterSpace = 20;
    cycleScrollView.pageControlDotSize = CGSizeMake(10, 10);
    cycleScrollView.imageArrays = imageArr;
    [self.view addSubview:cycleScrollView];

}

#pragma mark - HCCycleViewDelegate

- (void)cycleView:(HCCycleView *)cycleView didClickPictureIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张",index+1);
}


@end
