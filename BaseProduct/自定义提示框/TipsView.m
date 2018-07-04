//
//  TipsView.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/4.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "TipsView.h"

#define leftSpace 62
#define titleSpace 30
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface TipsView ()
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *alertHeaderV;
@property (nonatomic, strong) UIView *alertContentV;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@end

@implementation TipsView

+ (instancetype)shareInstance {
    static TipsView *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.window = [UIApplication sharedApplication].keyWindow;
    }
    return self;
}


- (void)showNewVersionViewWithTitle:(NSString*)title Content:(NSString*)content{
    _title = title;
    _content = content;
    
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.window.frame];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    }
    return _bgView;
}

- (UIImageView *)alertHeaderV{
    if (!_alertHeaderV) {
        UIImage *image = [UIImage imageNamed:@"newVersion_header"];
        _alertHeaderV = [[UIImageView alloc] initWithImage:image];
        CGFloat ViewH = (UISCREEN_WIDTH - 2*leftSpace)/(image.size.width/image.size.height);
//        CGFloat ViewY = (UISCREEN_HEIGHT - ViewH)/2;
        _alertHeaderV.frame = CGRectMake(leftSpace, 0, UISCREEN_WIDTH - 2*leftSpace, ViewH);
    }
    return _alertHeaderV;
}

- (UIView *)alertContentV{
    if (!_alertContentV) {
        _alertContentV = [UIView new];
        UIFont *font = [UIFont boldSystemFontOfSize:LineX(18)];
        CGRect rect = [_title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleSpace, titleSpace, CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, rect.size.height)];
        titleLab.font = font;
        titleLab.numberOfLines = 0;
        [_alertContentV addSubview:titleLab];
        font = [UIFont systemFontOfSize:LineX(14)];
        rect = [_content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(titleSpace, CGRectGetMaxY(titleLab.frame) + titleSpace, CGRectGetWidth(self.alertHeaderV.frame) - 2*titleSpace, rect.size.height)];
        contentLab.font = font;
        contentLab.numberOfLines = 0;
        [_alertContentV addSubview:contentLab];
        UIButton *cancelBtn = [UIButton new];
        cancelBtn.frame = CGRectMake(LineX(45), CGRectGetMaxY(contentLab.frame) + 2*titleSpace, LineX(100), LineX(25));
        [cancelBtn setImage:[UIImage imageNamed:@"newVersion_header"] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"下次再说" forState:UIControlStateNormal];
        cancelBtn.titleLabel.textColor = [UIColor whiteColor];
        [_alertContentV addSubview:cancelBtn];
        //
        UIButton *updateBtn = [UIButton new];
        updateBtn.frame = CGRectMake(LineX(45), CGRectGetMaxY(contentLab.frame) + 2*titleSpace, LineX(100), LineX(25));
        [updateBtn setImage:[UIImage imageNamed:@"newVersion_update"] forState:UIControlStateNormal];
        [updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        updateBtn.titleLabel.textColor = [UIColor whiteColor];
        [_alertContentV addSubview:updateBtn];
    }
    return _alertContentV;
}
@end
