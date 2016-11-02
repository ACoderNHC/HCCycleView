//
//  HCPageControl.m
//  Yoixi
//
//  Created by HC on 16/9/19.
//  Copyright © 2016年 Mostar Chow. All rights reserved.
//

#import "HCPageControl.h"

@implementation HCPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.borderWidth = 0.7;
    self.dotInterSpace = 10;
    self.dotSize = CGSizeMake(5, 5);
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    if (self.type != HCPageControlTypeBorder) {
        return;
    }
    if (currentPage >= 0 && self.subviews.count > 0) {
        for (NSInteger i=0; i<self.subviews.count; i++) {
            UIView *dot = self.subviews[i];
            if (i == currentPage) {
                dot.layer.backgroundColor = self.currentPageIndicatorTintColor.CGColor;
                dot.layer.borderWidth = self.borderWidth;
                dot.layer.borderColor = self.pageIndicatorTintColor.CGColor;

            } else {
                dot.layer.backgroundColor = self.pageIndicatorTintColor.CGColor;
                dot.layer.borderWidth = 0;
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.subviews.count == 0) {
        return;
    }
    
    for (NSInteger i=0; i<self.subviews.count; i++) {
        UIView *dot = self.subviews[i];
        if (self.type == HCPageControlTypeBorder) {
            if (i == self.currentPage) {
                dot.layer.backgroundColor = self.currentPageIndicatorTintColor.CGColor;
                dot.layer.borderWidth = self.borderWidth;
                dot.layer.borderColor = self.pageIndicatorTintColor.CGColor;
            }        
        }
        CGRect frame = dot.frame;
        frame.origin.y = 0;
        frame.origin.x = self.dotInterSpace + i * (self.dotSize.width + self.dotInterSpace);
        frame.size.width = self.dotSize.width;
        frame.size.height = self.dotSize.height;
        dot.frame = frame;
        dot.layer.cornerRadius = self.dotSize.width*0.5;
    }

    
}

@end
