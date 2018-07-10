//
//  GDUMLoginManager.h
//  TheBull
//
//  Created by 郭达 on 2018/4/18.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UMLoginResponse) (id reponse);

typedef enum : NSUInteger {
    GDLoginType_weibo=0,
    GDLoginType_weixin=1
} GDLoginType;

@interface GDUMLoginManager : NSObject
+ (instancetype)shareInstance;


/**
 第三方登录

 @param loginType loginType description
 @param vc vc description
 @param response response description  
 */
- (void)theThirdLoginWithType:(GDLoginType)loginType VC:(UIViewController*)vc AndResponse:(UMLoginResponse)response;

@end
