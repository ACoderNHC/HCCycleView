//
//  HCCycleView.h
//  Yoixi
//
//  Created by HC on 16/9/19.
//  Copyright © 2016年 Mostar Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,HCPageControlPosition) {
    HCPageControlPositionMiddle,
    HCPageControlPositionLeft,
    HCPageControlPositionRight
};

typedef NS_ENUM(NSUInteger,HCPageControlType) {
    HCPageControlTypeNone,
    HCPageControlTypeBorder
};


@class HCCycleView;

@protocol HCCycleViewDelegate <NSObject>
@optional
- (void)cycleView:(HCCycleView *)cycleView didClickPictureIndex:(NSInteger)index;
@end

@interface HCCycleView : UIView
// 轮播时间间隔
@property (nonatomic,assign) NSTimeInterval timerInterVal;
// 是否自动轮播
@property (nonatomic,assign) BOOL isAutoScroll;
// 占位图片
@property (nonatomic,strong) UIImage *placeholderImage;
/** pageControl */
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
/*** 图片数组 */
@property (nonatomic,copy) NSArray *imageArrays;
/*** 代理 */
@property (nonatomic,weak) id<HCCycleViewDelegate> delegate;

/*** 推荐初始化方法 */
+ (instancetype)cycleViewWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray placeholderImage:(UIImage *)placeholderImage;

/*** 点击图片Block */
@property (nonatomic,copy) void (^didClickPicture)(NSInteger);

/*** 滚动方法 */
- (void)scrollToIndex:(NSInteger)index animate:(BOOL)animate;

@end
