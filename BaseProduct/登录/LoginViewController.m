//
//  LoginViewController.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/10.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic, strong) UIImageView *phoneImgaeV;
@property(nonatomic, strong) UITextField *phoneTextF;
@property(nonatomic, strong) UITextField *passWordTextF;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UIImageView *passWordImgaeV;
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view.
}

//需要重写
-(void)setRightNavBar{
    UIButton *rightBarButton= [UIButton new];
    rightBarButton.frame = CGRectMake(0, 0, 19, 19);
//    [rightBarButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)loginClick{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark = lazy load

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UITextField *)phoneTextF{
    if (!_phoneTextF) {
        _phoneTextF = [[UITextField alloc] init];
        _phoneTextF.backgroundColor = [UIColor whiteColor];
    }
    return _phoneTextF;
}
- (UITextField *)passWordTextF{
    if (!_passWordTextF) {
        _passWordTextF = [[UITextField alloc] init];
        _passWordTextF.backgroundColor = [UIColor whiteColor];
    }
    return _passWordTextF;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0 )];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:nil];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        [_loginBtn setTitle:@"" forState:(UIControlState)UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIImageView *)phoneImgaeV{
    if(!_phoneImgaeV){
        _phoneImgaeV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [self.view addSubview:_phoneImgaeV];
    }
    return _phoneImgaeV;
}

- (UIImageView *)passWordImgaeV{
    if(!_passWordImgaeV){
        _passWordImgaeV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [self.view addSubview:_passWordImgaeV];
    }
    return _passWordImgaeV;
}


@end
