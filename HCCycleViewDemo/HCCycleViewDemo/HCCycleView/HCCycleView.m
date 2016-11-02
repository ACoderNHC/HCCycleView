//
//  HCCycleView.m
//  Yoixi
//
//  Created by HC on 16/9/19.
//  Copyright © 2016年 Mostar Chow. All rights reserved.
//

#import "HCCycleView.h"
#import "HCPageControl.h"
#import <UIImageView+WebCache.h>

@interface HCCycleView () <UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *currentImageView;
@property (nonatomic,weak) UIImageView *secondImageView;
@property (nonatomic,weak) UIImageView *bgImageView;
@property (nonatomic,weak) HCPageControl *pageControl;
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,assign) CGFloat preOffset;
/*** 处理后的图片数组 */
@property (nonatomic,strong) NSMutableArray *dealedImageArray;
@end

@implementation HCCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
        [self setup];
    }
    return self;
}

+ (instancetype)cycleViewWithFrame:(CGRect)frame delegate:(id<HCCycleViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage {
    HCCycleView *cycleView = [[HCCycleView alloc] initWithFrame:frame];
    cycleView.delegate = delegate;
    if (placeholderImage != nil) {
        cycleView.placeholderImage = placeholderImage;
    }
    return cycleView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        if (_isAutoScroll) {
            [self stopTimer];
        }
    }
}

- (void)initialization {
    // 默认值
    self.pageControlType = HCPageControlTypeBorder;
    self.currentPageControlColor = [UIColor whiteColor];
    self.pageControlColor = [UIColor grayColor];
    self.pageControlBottom = 10;
    self.pageControlDotSize = CGSizeMake(8, 8);
    self.pageControlDotBorderWidth = 0.70;
    self.pageControlDotInterSpace = 10;
    self.timerInterVal = 5;
    self.isAutoScroll = YES;
    self.pageControlCustomFrame = CGRectZero;
}

- (void)setup {
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView = bgImageView;
    [self insertSubview:bgImageView atIndex:0];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview: self.scrollView];
    UIImageView *currentImageView = [[UIImageView alloc] init];
    self.currentImageView = currentImageView;
    [self.scrollView addSubview:self.currentImageView];
    UIImageView *secondImageView = [[UIImageView alloc] init];
    self.secondImageView = secondImageView;
    [self.scrollView addSubview:self.secondImageView];
    
    // 添加点击手势
    self.currentImageView.userInteractionEnabled = YES;
    [self.currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    self.secondImageView.userInteractionEnabled = YES;
    [self.secondImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];

    HCPageControl *pageControl = [[HCPageControl alloc] init];
    pageControl.type = self.pageControlType;
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor = self.currentPageControlColor;
    pageControl.pageIndicatorTintColor = self.pageControlColor;
    self.pageControl = pageControl;
    [self addSubview:self.pageControl];
    
}

#pragma mark - Lazy

- (NSMutableArray *)dealedImageArray {
    if (_dealedImageArray == nil) {
        _dealedImageArray = [NSMutableArray array];
    }
    return _dealedImageArray;
}

#pragma mark - Setter

- (void)setCurrentPageControlColor:(UIColor *)currentPageControlColor {
    _currentPageControlColor = currentPageControlColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageControlColor;
}

- (void)setPageControlColor:(UIColor *)pageControlColor {
    _pageControlColor = pageControlColor;
    self.pageControl.pageIndicatorTintColor = pageControlColor;
}

- (void)setImageArrays:(NSArray *)imageArrays {
    _imageArrays = [imageArrays copy];
    if (imageArrays.count > 0) {
        [self.dealedImageArray removeAllObjects];
        // 筛选图片
        [self dealImagesArray:imageArrays];
        
        if (self.dealedImageArray.count == 0) {  // 无图片
            return;
        }
        
        NSObject *currentImage = self.dealedImageArray[0];
        [self setImageView:_currentImageView withImage:currentImage];
        self.pageControl.numberOfPages = self.dealedImageArray.count;
        [self layoutSubviews];

        if (self.dealedImageArray.count < 2) {
            // 单页
            self.scrollView.scrollEnabled = NO;
        } else {
            // 多页
            self.currentImageView.tag = 0;
            self.secondImageView.tag = 1;
            if (self.isAutoScroll) {
                [self startTimer];
            }
        }
        
    }
}

- (void)setPageControlType:(HCPageControlType)pageControlType {
    _pageControlType = pageControlType;
    self.pageControl.type = pageControlType;
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    self.bgImageView.image = placeholderImage;
}

#pragma mark - Action

// 点击图片回调
- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(cycleView:didClickPictureIndex:)]) {
        [self.delegate cycleView:self didClickPictureIndex:tap.view.tag];
    }
    !self.didClickPicture?:self.didClickPicture(tap.view.tag);
}

#pragma mark - Method

- (void)scrollToIndex:(NSInteger)index animate:(BOOL)animate {
    _currentImageView.tag = index;
    self.pageControl.currentPage = index;
    NSObject *curImage = self.dealedImageArray[index];
    [self setImageView:_currentImageView withImage:curImage];
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:animate];
}

- (void)startTimer {
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterVal target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)autoScroll {
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width*2, 0) animated:YES];
}

/** 加载图片 */
- (void)setImageView:(UIImageView *)imageView withImage:(id)image {
    if ( [image isKindOfClass:[UIImage class]]) {
        imageView.image = (UIImage *)image;
    } else if ([image isKindOfClass:[NSString class]]) {
        if ([(NSString *)image hasPrefix:@"http:"] || [(NSString *)image hasPrefix:@"https:"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)image] placeholderImage:self.placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (cacheType == SDImageCacheTypeNone) {
                    if (image == nil) {
                        return;
                    }
                    
                    CATransition *transition = [CATransition animation];
                    transition.duration = .5;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [imageView.layer addAnimation:transition forKey:@"fade"];
                }
            }];
        }
    }
}

/** 筛选图片 */
- (void)dealImagesArray:(NSArray *)imageArrays {
    for (NSInteger i=0; i<imageArrays.count; i++) {
        NSObject *currentImage = imageArrays[i];
        if ([currentImage isKindOfClass:[UIImage class]]) {
            [self.dealedImageArray addObject:currentImage];
        } else if ([currentImage isKindOfClass:[NSString class]]) {
            if ([(NSString *)currentImage hasPrefix:@"http:"] || [(NSString *)currentImage hasPrefix:@"https:"]) {
                [self.dealedImageArray addObject:currentImage];
            }
        }
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    _scrollView.frame = self.bounds;
    _pageControl.borderWidth = _pageControlDotBorderWidth;
    _pageControl.dotSize = _pageControlDotSize;
    _pageControl.dotInterSpace = _pageControlDotInterSpace;
    _pageControl.frame = CGRectMake(0, 0, (_pageControlDotSize.width + _pageControlDotInterSpace) * self.dealedImageArray.count + _pageControlDotInterSpace, _pageControlDotSize.height);
    
    if (self.dealedImageArray.count == 0) {
        return;
    } else if (self.dealedImageArray.count == 1) {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        _currentImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, 0);
        _currentImageView.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        _secondImageView.frame = CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height);
        [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    }
    
    
    if (CGRectEqualToRect(self.pageControlCustomFrame, CGRectZero)) {
        CGRect frame = self.pageControl.frame;
        frame.origin.y = self.bounds.size.height - _pageControlBottom - _pageControlDotSize.height;
        _pageControl.frame = frame;
        switch (self.pageControlPosition) {
            case HCPageControlPositionMiddle:
            {
                CGPoint center = _pageControl.center;
                center.x = self.bounds.size.width*0.5;
                _pageControl.center = center;
                break;
            }
            case HCPageControlPositionLeft:
            {
                frame.origin.x = 0;
                _pageControl.frame = frame;
                break;
            }
            case HCPageControlPositionRight:
            {
                frame.origin.x = self.bounds.size.width - frame.size.width;
                _pageControl.frame = frame;
                break;
            }
            default:
                break;
        }
    } else {
        self.pageControl.frame = self.pageControlCustomFrame;
    }
    
    // 修复 xib 加载时布局还未更新产生的页码错乱问题
    [self scrollToIndex:0 animate:NO];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.dealedImageArray.count == 0) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.x;
    
    if (offset < self.bounds.size.width) {
        // 左滑
        _secondImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _secondImageView.tag = (_currentImageView.tag - 1 + self.dealedImageArray.count) % (self.dealedImageArray.count);
        NSObject *secondImage = self.dealedImageArray[_secondImageView.tag];
        [self setImageView:_secondImageView withImage:secondImage];
        
        // 更新页码
        if (offset < self.bounds.size.width * 0.5) {
            _pageControl.currentPage = _secondImageView.tag;
            if (offset == 0) {
                // 更换页面
                _currentImageView.tag = _secondImageView.tag;
                NSObject *secondImage = self.dealedImageArray[_secondImageView.tag];
                [self setImageView:_currentImageView withImage:secondImage];
                self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
            }
        } else {
            _pageControl.currentPage = _currentImageView.tag;
        }
        
        
    } else if (offset > self.bounds.size.width) {
        // 右滑
        _secondImageView.frame = CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height);
        _secondImageView.tag = (_currentImageView.tag + 1) % (self.dealedImageArray.count);
        NSObject *secondImage = self.dealedImageArray[_secondImageView.tag];
        [self setImageView:_secondImageView withImage:secondImage];

        // 更新页码
        if (offset > self.bounds.size.width * 1.5) {
            _pageControl.currentPage = _secondImageView.tag;
            if (offset >= 2 * self.bounds.size.width) {
                // 更换页面
                _currentImageView.tag = _secondImageView.tag;
                NSObject *secondImage = self.dealedImageArray[_secondImageView.tag];
                [self setImageView:_currentImageView withImage:secondImage];
                self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
            }
        } else {
            _pageControl.currentPage = _currentImageView.tag;
        }

        
    } else {
        _pageControl.currentPage = _currentImageView.tag;
    }
    _preOffset = offset;

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_isAutoScroll) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isAutoScroll) {
        [self startTimer];
    }
}

@end
