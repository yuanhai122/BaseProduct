//
//  GDUMShareManager.h
//  TheBull
//
//  Created by 郭达 on 2018/4/18.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SharedSuccess)(NSString*sucmsg);//确定返回邀请码
typedef void(^SharedFailed)(NSString *errmsg,NSInteger errcode);
@interface GDUMShareManager : NSObject

+ (instancetype)shareInstance;

/**
 整个分享

 @param vc vc description
 @param title title description
 @param sharedtext sharedtext description
 @param descr descr description
 @param url url description
 @param thumb thumb description
 @param success success description
 @param failed failed description
 */
- (void)umsharewithVC:(UIViewController*)vc Title:(NSString*)title sharedText:(NSString*)sharedtext descr:(NSString*)descr url:(NSString*)url thumb:(id)thumb SharedSuccess:(SharedSuccess)success sharedFail:(SharedFailed)failed;


/**
 单个自定义分享

 @param platformType platformType description
 @param vc vc description
 @param title title description
 @param descr descr description
 @param url url description
 @param thumb thumb description
 @param success success description
 @param failed failed description
 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType VC:(UIViewController*)vc withTitle:(NSString *)title descr:(NSString *)descr url:(NSString *)url thumb:(id)thumb SharedSuccess:(SharedSuccess)success sharedFail:(SharedFailed)failed;

- (NSString*)checkError:(NSError*)error;

@end
