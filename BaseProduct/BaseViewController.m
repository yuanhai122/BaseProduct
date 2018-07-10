//
//  BaseViewController.m
//  BaseProduct
//
//  Created by 袁海 on 2018/7/2.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    __weak UILabel * titleLabel;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark 左侧返回按钮
- (void)customBackBarButtonItem{
    UIImage * image = [UIImage imageNamed:@""];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        UIBarButtonItem * negativeSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpace.width = -12;
        self.navigationItem.leftBarButtonItems = @[negativeSpace,barBtn];
    }else{
        self.navigationItem.leftBarButtonItem = barBtn;
    }
}

- (void)backBtn:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 自定义title
- (void)custonTitle:(NSString *)title{
    if (titleLabel) {
        [titleLabel removeFromSuperview];
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    titleLabel = label;
    self.navigationItem.titleView = titleLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
