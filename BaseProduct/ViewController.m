//
//  ViewController.m
//  BaseProduct
//
//  Created by 袁海 on 2018/7/1.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "ViewController.h"
#import "NewVersionAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NewVersionAlertView showNewVersionViewWithTitle:@"模式在这里没有必要因为视图控制器不保留在被派遣的块的副本" Content:@"你想要避免周期哪里块所有者保留块和块 weakSelf 保留所有者。有的 weakSelf 模式在这里没有必要因为视图控制器不保留在被派遣的块的副本。"];
    [NewVersionAlertView shareInstance].alert_Type = Alert_NormalType;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
