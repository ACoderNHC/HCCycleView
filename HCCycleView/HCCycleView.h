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
@property (nonatomic,assign) NSTimeInterval timerInterVal;
@property (nonatomic,assign) BOOL isAutoScroll;
@property (nonatomic,strong) UIImage *placeholderImage;

/** pageControl */
@property (nonatomic,assign) HCPageControlType pageControlType;
@property (nonatomic,assign) CGFloat pageControlDotInterSpace;
@property (nonatomic,assign) CGSize pageControlDotSize;
@property (nonatomic,assign) CGFloat pageControlDotBorderWidth;
@property (nonatomic,assign) CGRect pageControlCustomFrame;
@property (nonatomic,assign) CGFloat pageControlBottom;
@property (nonatomic,assign) HCPageControlPosition pageControlPosition;
@property (nonatomic,strong) UIColor *pageControlColor;
@property (nonatomic,strong) UIColor *currentPageControlColor;
/*** 图片数组 */
@property (nonatomic,copy) NSArray *imageArrays;
/*** 代理 */
@property (nonatomic,weak) id<HCCycleViewDelegate> delegate;

/*** 初始化方法 */
+ (instancetype)cycleViewWithFrame:(CGRect)frame delegate:(id <HCCycleViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/*** 点击图片Block */
@property (nonatomic,copy) void (^didClickPicture)(NSInteger);

/*** 滚动方法 */
- (void)scrollToIndex:(NSInteger)index animate:(BOOL)animate;

@end
