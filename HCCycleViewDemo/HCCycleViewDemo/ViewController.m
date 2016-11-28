//
//  ViewController.m
//  HCCycleViewDemo
//
//  Created by HC on 2016/11/1.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "ViewController.h"
#import "HCNormalViewController.h"
#import "HCCustomViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            // 代码创建
            UIStoryboard *defaultStroyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([HCNormalViewController class]) bundle:nil];
            HCNormalViewController *defaultVc = [defaultStroyBoard instantiateInitialViewController];
            [self.navigationController pushViewController:defaultVc animated:YES];
            break;
        }
            
        case 1:
        {
            // xib创建
            UIStoryboard *customStroyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([HCCustomViewController class]) bundle:nil];
            HCCustomViewController *customVc = [customStroyBoard instantiateInitialViewController];
            [self.navigationController pushViewController:customVc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"创建方式";
            break;
        case 1:
            cell.textLabel.text = @"自定义样式";
            break;
        default:
            break;
    }
    return cell;
}



@end
