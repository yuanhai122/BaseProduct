//
//  TipsView.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/4.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Alert_Type) {
    Alert_NormalType = 1,
    Alert_ForceUpdateType,
};
@interface NewVersionAlertView : UIView

@property (nonatomic, copy) void(^alert_update)(void);
@property (nonatomic, copy) void(^alert_cancel)(void);
@property (nonatomic, assign) Alert_Type alert_Type;

+ (instancetype)shareInstance;
+ (void)showNewVersionViewWithTitle:(NSString*)title Content:(NSString*)content;
@end
