//
//  TipsView.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/4.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsView : UIView

@property (nonatomic, copy) void(^alert_update)(void);
@property (nonatomic, copy) void(^alert_cancel)(void);
@end
