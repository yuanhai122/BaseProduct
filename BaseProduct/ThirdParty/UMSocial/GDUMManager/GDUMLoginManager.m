//
//  GDUMLoginManager.m
//  TheBull
//
//  Created by 郭达 on 2018/4/18.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "GDUMLoginManager.h"

@implementation GDUMLoginManager

+ (instancetype)shareInstance {
    static GDUMLoginManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (void)theThirdLoginWithType:(GDLoginType)loginType VC:(UIViewController*)vc AndResponse:(UMLoginResponse)response {
    
    UMSocialPlatformType needType = UMSocialPlatformType_WechatSession;
    if (loginType == GDLoginType_weibo) {
        needType = UMSocialPlatformType_Sina;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:needType currentViewController:vc completion:^(id result, NSError *error) {
        if (error) {
//            NSString *errMsg = [[GDUMShareManager shareInstance] checkError:error];
//            [TipsView showError:errMsg];
        }else {
            if (response) {
                response(result);
            }
        }
    }];
    
    
}

@end
