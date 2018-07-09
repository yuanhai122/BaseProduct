//
//  BaseTabBarController.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/9.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubControllers];
    [self formulateTabBarItems];
}

+ (void)initialize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = rgb(102,102,102);

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = rgb(232,56,30);
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)addSubControllers {
    NSArray *classArr = @[@"", @"", @"", @"",@""];
    NSArray *titles = @[@"",@"",@"",@" ",@""];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < classArr.count; i++) {
        Class class = NSClassFromString(classArr[i]);
        UIViewController * vc = [[class alloc] init];
        vc.title = titles[i];
        BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
}

- (void)formulateTabBarItems {
    NSArray *titles = @[@"",@"",@"",@"",@""];
    NSArray *images = @[@"", @"", @"", @"",@""];
    NSArray *selectedImages = @[@"", @"", @"", @"",@""];
    //定制子视图的标签
    for (int i = 0; i < titles.count; i++) {
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:titles[i] image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UIViewController * vc = self.viewControllers[i];
        vc.tabBarItem = item;
    }
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
