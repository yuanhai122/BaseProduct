//
//  ViewController.m
//  BaseProduct
//
//  Created by 袁海 on 2018/7/1.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "ViewController.h"
#import "NewVersionAlertView.h"
#import "ChangeLanguage.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UILabel *languageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [NewVersionAlertView showNewVersionViewWithTitle:@"模式在这里没有必要因为视图控制器不保留在被派遣的块的副本" Content:@"你想要避免周期哪里块所有者保留块和块 weakSelf 保留所有者。有的 weakSelf 模式在这里没有必要因为视图控制器不保留在被派遣的块的副本。"];
//    [NewVersionAlertView shareInstance].alert_Type = Alert_NormalType;
    
    _changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, UISCREEN_WIDTH, 40)];
    [_changeButton setBackgroundColor:[UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1.0]];
    [_changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _changeButton];
    
    _languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, UISCREEN_WIDTH, 40)];
    [self.view addSubview:_languageLabel];
    _languageLabel.backgroundColor = [UIColor yellowColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    //初始化应用语言
    
    [ChangeLanguage initUserLanguage];
    
    NSBundle *bundle = [ChangeLanguage bundle];
    
    /*
     
     localizedStringForKey:@"change_language" value:nil table:@"English"
     
     
     
     localizedStringForKey:各个语言文件中共同的名称
     
     table: English.strings 多语言文件夹的名称
     
     */
    
    NSString *str = localizedString(@"change_language");
    //[bundle localizedStringForKey:@"change_language" value:nil table:@"English"];
    
    NSString *buttonStr = [bundle localizedStringForKey:@"button" value:nil table:@"English"];
    
    [_changeButton setTitle:buttonStr forState:UIControlStateNormal];
    
    _languageLabel.text = str;
}

//切换语言的点击方法
- (void)change {
    //修改语言
    NSString *language = [ChangeLanguage userLanguage];
    if ([language isEqualToString:@"en"]) {
        [ChangeLanguage setUserlanguage:@"zh-Hans"];
    }else{
        [ChangeLanguage setUserlanguage:@"en"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:self];
}

//点击改变语言，代理方法刷新界面
- (void)changeLanguage{
    [_changeButton setTitle:[[ChangeLanguage bundle] localizedStringForKey:@"button" value:nil table:@"English"] forState:UIControlStateNormal];
    _languageLabel.text =[[ChangeLanguage bundle] localizedStringForKey:@"change_language" value:nil table:@"English"];
}

//适当的位置移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
