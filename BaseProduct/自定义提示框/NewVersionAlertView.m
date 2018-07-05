//
//  TipsView.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/4.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "NewVersionAlertView.h"

#define leftSpace 31
#define titleSpace 30
#define DismissDuration .5
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface NewVersionAlertView ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *alertHeaderV;
@property (nonatomic, strong) UIView *alertContentV;
@property (nonatomic, strong) UIView *alertContainerV;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@end

@implementation NewVersionAlertView

+ (instancetype)shareInstance {
    static NewVersionAlertView *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.window = [[[UIApplication sharedApplication] delegate] window];
    }
    return self;
}

+ (void)showNewVersionViewWithTitle:(NSString*)title Content:(NSString*)content{
    dispatch_async(dispatch_get_main_queue(), ^{
       [[self shareInstance] showNewVersionViewWithTitle:title Content:content];
    });
}

- (void)showNewVersionViewWithTitle:(NSString*)title Content:(NSString*)content{
    _title = title;
    _content = content;
    self.alertContainerV.frame = CGRectMake(0, 0, UISCREEN_WIDTH - 2*leftSpace, CGRectGetHeight(self.alertHeaderV.frame) + CGRectGetHeight(self.alertContentV.frame));
    self.alertContainerV.center = self.bgView.center;
    [self.alertContainerV addSubview:self.alertHeaderV];
    [self.alertContainerV addSubview:self.alertContentV];
    [self.bgView addSubview:self.alertContainerV];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.window.bounds];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        [self.window addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)alertHeaderV{
    if (!_alertHeaderV) {
        UIImage *image = [UIImage imageNamed:@"newVersion_header"];
        _alertHeaderV = [[UIImageView alloc] initWithImage:image];
        CGFloat ViewH = CGRectGetWidth(self.alertContainerV.frame)/(image.size.width/image.size.height);
        _alertHeaderV.frame = CGRectMake(0, 0, CGRectGetWidth(self.alertContainerV.frame), ViewH);
    }
    return _alertHeaderV;
}

- (UIView *)alertContentV{
    if (!_alertContentV) {
        _alertContentV = [UIView new];
        _alertContentV.backgroundColor = [UIColor whiteColor];
        //
        UIFont *font = [UIFont boldSystemFontOfSize:LineX(18)];
        CGRect rect = [_title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleSpace, titleSpace, CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, rect.size.height)];
        titleLab.text = _title;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = font;
        titleLab.numberOfLines = 0;
        titleLab.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
        [_alertContentV addSubview:titleLab];
        //
        font = [UIFont systemFontOfSize:LineX(14)];
        rect = [_content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(titleSpace, CGRectGetMaxY(titleLab.frame) + titleSpace, CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, rect.size.height)];
        contentLab.text = _content;
        contentLab.font = font;
        contentLab.numberOfLines = 0;
        contentLab.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
        [_alertContentV addSubview:contentLab];
        UIButton *cancelBtn = [UIButton new];
        cancelBtn.frame = CGRectMake(LineX(20), CGRectGetMaxY(contentLab.frame) + titleSpace, LineX(100), LineX(35));
        [cancelBtn setTitle:@"下次再说" forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"newVersion_cancel"] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:LineX(15)];
        cancelBtn.layer.cornerRadius = 10;
        cancelBtn.clipsToBounds = YES;
        //
        UIButton *updateBtn = [UIButton new];
        updateBtn.frame = CGRectMake(CGRectGetWidth(self.alertHeaderV.frame) - LineX(20) - LineX(100), CGRectGetMaxY(contentLab.frame) + titleSpace, LineX(100), LineX(33));
        [updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [updateBtn setBackgroundImage:[UIImage imageNamed:@"newVersion_update"] forState:UIControlStateNormal];
        [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [updateBtn addTarget:self action:@selector(updateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        updateBtn.titleLabel.font = [UIFont systemFontOfSize:LineX(15)];
        updateBtn.layer.cornerRadius = 10;
        updateBtn.clipsToBounds = YES;
        
        if (_alert_Type == Alert_ForceUpdateType) {
            updateBtn.frame = CGRectMake((CGRectGetWidth(self.alertHeaderV.frame) - LineX(100))/2, CGRectGetMaxY(contentLab.frame) + titleSpace, LineX(100), LineX(35));
            [_alertContentV addSubview:updateBtn];
        }else {
            [_alertContentV addSubview:cancelBtn];
            [_alertContentV addSubview:updateBtn];
        }
        _alertContentV.frame = CGRectMake(0, CGRectGetHeight(self.alertHeaderV.frame) - 1, CGRectGetWidth(self.alertHeaderV.frame), CGRectGetMaxY(updateBtn.frame) + LineX(20));
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:_alertContentV.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10 , 10)].CGPath;
        _alertContentV.layer.masksToBounds = YES;
        _alertContentV.layer.mask = maskLayer;
    }
    return _alertContentV;
}

- (UIView *)alertContainerV{
    if (!_alertContainerV) {
        _alertContainerV = [UIView new];
        _alertContainerV.backgroundColor = [UIColor clearColor];
        _alertContainerV.frame = CGRectMake(0, 0, UISCREEN_WIDTH - 2*leftSpace, 0);
    }
    return _alertContainerV;
}

- (void)cancelBtnClick{
    if (self.alert_cancel) {
        self.alert_cancel();
    }
    [UIView animateWithDuration:DismissDuration animations:^{
        [self dismissView];
    }];
}

- (void)dismissView{
    [_bgView removeFromSuperview];
    _bgView = nil;
}
- (void)updateBtnClick{
    if (self.alert_update) {
        self.alert_update();
    }
    [UIView animateWithDuration:DismissDuration animations:^{
        [self dismissView];
    }];
}
@end
