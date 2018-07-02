//
//  BullAdvertiseManager.h
//  TheBull
//
//  Created by 郭达 on 2018/5/22.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAnimatedImage.h"
#import "AdvertiseModel.h"

@interface BullAdvertiseManager : NSObject

+ (instancetype)defaultManager;

/**
 显示广告,只调用一个接口就ok

 @param rootwindow rootwindow 
 */
- (void)handle_AdvertiseWithSuperWindow:(UIWindow*)rootwindow;

@end




@interface GDAdvertiseView : UIView

@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic, strong) FLAnimatedImageView *gifImgView;

/**
 点击广告跳详情
 */
@property (nonatomic, copy) void(^goAdDetailBlock)(void) ;


/**
 点击跳过按钮
 */
@property (nonatomic, copy) void(^skipAdViewBlock)(void);

- (void)updateImgDataswith:(NSData *)datasource andSourceName:(AdvertiseModel*)model;

@end




