//
//  HCCustomModeViewController.m
//  HCCycleViewDemo
//
//  Created by HC on 2016/11/1.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "HCCustomViewController.h"
#import "HCCycleView.h"

@interface HCCustomViewController () <HCCycleViewDelegate>
@property (weak, nonatomic) IBOutlet HCCycleView *xibCycleView;

@end

@implementation HCCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"自定义样式";
    // 图片数组
    NSArray *imageArr = @[@"http://image72.360doc.com/DownloadImg/2014/04/2301/40991904_7.jpg",
                          @"http://img4.duitang.com/uploads/blog/201406/28/20140628174102_R8Hhd.thumb.700_0.jpeg",
                          [UIImage imageNamed:@"local_image.jpg"],
                          @"http://uploadfile.bizhizu.cn/2014/0507/20140507103639644.jpg",
                          @"http://image55.360doc.com/DownloadImg/2012/10/2517/27773420_5.jpg",
                          @"http://pic62.nipic.com/file/20150303/17961491_092446597000_2.jpg"
                          ];
    self.xibCycleView.placeholderImage = PLACEHOLDER_IMAGE;
    self.xibCycleView.imageArrays = imageArr;
    self.xibCycleView.delegate = self;

    // 设置PageControl边框样式
    self.xibCycleView.pageControlType = HCPageControlTypeBorder;
    // 设置边框大小
    self.xibCycleView.pageControlDotBorderWidth = 1;
    // 设置PageControl的dot的颜色
    self.xibCycleView.currentPageControlColor = [UIColor yellowColor];
    self.xibCycleView.pageControlColor = [UIColor purpleColor];
    // 设置dot间距
    self.xibCycleView.pageControlDotInterSpace = 12;
    // 设置dot大小
    self.xibCycleView.pageControlDotSize = CGSizeMake(10, 10);
    // 设置PageControl水平位置
    self.xibCycleView.pageControlPosition = HCPageControlPositionRight;
    // 设置PageControl底部距离
    self.xibCycleView.pageControlBottom = 15;

}

#pragma mark - HCCycleViewDelegate

- (void)cycleView:(HCCycleView *)cycleView didClickPictureIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张",index+1);
}


@end
