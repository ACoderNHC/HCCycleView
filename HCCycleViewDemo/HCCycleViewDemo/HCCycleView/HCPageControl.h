//
//  HCPageControl.h
//  Yoixi
//
//  Created by HC on 16/9/19.
//  Copyright © 2016年 Mostar Chow. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "HCCycleView.h"

@interface HCPageControl : UIPageControl
@property (nonatomic,assign) HCPageControlType type;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) CGFloat dotInterSpace;
@property (nonatomic,assign) CGSize dotSize;
@end
