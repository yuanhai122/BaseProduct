//
//  GDUMShareManager.m
//  TheBull
//
//  Created by 郭达 on 2018/4/18.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "GDUMShareManager.h"
#import "AppDelegate.h"
@implementation GDUMShareManager

+ (instancetype)shareInstance {
    static GDUMShareManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 整个分享
- (void)umsharewithVC:(UIViewController*)vc Title:(NSString*)title sharedText:(NSString*)sharedtext descr:(NSString*)descr url:(NSString*)url thumb:(id)thumb SharedSuccess:(SharedSuccess)success sharedFail:(SharedFailed)failed{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_Sina)]];
//    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"123";
//    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewBackgroundColor = [UIColor yellowColor];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].shareContainerConfig.shareContainerCornerRadius = 10;
    
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.text = sharedtext;
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:@"logo"]];
        shareObject.webpageUrl = url;
        messageObject.shareObject = shareObject;
        
        [weakSelf shareToPlatform:platformType messageObject:messageObject currentVC:vc sharedSuccess:success sharedFail:failed];
        
    }];
}

#pragma mark - 单个分享  需要type
///单个分享，指定type
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType VC:(UIViewController*)vc withTitle:(NSString *)title descr:(NSString *)descr url:(NSString *)url thumb:(id)thumb SharedSuccess:(SharedSuccess)success sharedFail:(SharedFailed)failed
{

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:@"logo"]];
    shareObject.webpageUrl = url;
    messageObject.shareObject = shareObject;
    [self shareToPlatform:platformType messageObject:messageObject currentVC:vc sharedSuccess:success sharedFail:failed];

}
#pragma mark - 分享功能
- (void)shareToPlatform:(UMSocialPlatformType)type messageObject:(UMSocialMessageObject*)messageObject currentVC:(UIViewController*)vc sharedSuccess:(SharedSuccess)success sharedFail:(SharedFailed)failed {
    __weak typeof(self) weakSelf = self;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:vc completion:^(id result, NSError *error) {
        if (error) {
            NSString *errMsg = [weakSelf checkError:error];
            if (failed) {
                failed(errMsg,error.code);
            }
        }else {
            if (success) {
                success(@"分享成功");
            }
        }
        
        
    }];
}
- (NSString*)checkError:(NSError*)error {
    NSString  *result = nil;
    if (!error) {
        result = @"分享成功";
    }else {
        NSMutableString *str = [[NSMutableString alloc] init];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@",error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"%@",str];
        }else {
            result = @"分享失败";
        }
        
    }
    return result;
    
}

@end
