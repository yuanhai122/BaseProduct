//
//  AppDelegate.m
//  BaseProduct
//
//  Created by 袁海 on 2018/7/1.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "AppDelegate.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "BullAdvertiseManager.h"

static NSString *channel = @"Publish channel";
static BOOL isProduction = NO;
@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //拿到唯一标识
    NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [KeyChainDataManager saveUUID:deviceUUID];
    [self configUM];
    [self bull_JPushConfigWithLaunchOptions:launchOptions];//极光
    [self setRootAndAdvertise];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    return YES;
}

#pragma mark - root & advertise
- (void)setRootAndAdvertise {//替换删除之前
//    HMWTabBarController* tab = [[HMWTabBarController alloc] init];
//    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    [[BullAdvertiseManager defaultManager] handle_AdvertiseWithSuperWindow:self.window];
//    [BullForceUpdateManager checkAppVersionIsNeedUpdate];//检查强制更新 创建完tabbar之后！！
}

#pragma mark - Jpush
- (void)bull_JPushConfigWithLaunchOptions:(NSDictionary*)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {// iOS8, iOS9
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    //    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
    }];
//    userModel *model=[[userManager shareManager]getUserModel];
//    if ([utilsFunction checkNullString:model.sid]){
//        [JPUSHService setAlias:model.ub_id completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//        } seq:0];
//    }
}
#pragma mark - 设置UM
- (void)configUM {
    //    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMengAppKey];
    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:kUMengAppKey channel:nil];
    [MobClick setScenarioType:E_UM_NORMAL];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWexinAppID appSecret:kWeixinAppKey redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppID  appSecret:kSinaKey redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [JPUSHService registerDeviceToken:deviceToken];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");
}

//iOS7以上 iOS10以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
//    [[BullJPushManager shareInstance]getPushMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//前台iOS10 代替系统的usernotification
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //        [[BullJPushManager shareInstance]getPushMessage:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
//ios 10  程序运行于前台，后台 或杀死 点击推送通知 都会走这个方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {//杀死后台点击通知栏
        [JPUSHService handleRemoteNotification:userInfo];
        //推送打开
        if (userInfo){
            [JPUSHService handleRemoteNotification:userInfo];
//            [[BullJPushManager shareInstance]getPushMessage:userInfo];
            completionHandler(UIBackgroundFetchResultNewData);
        }
    }else {//前台运行时
        
    }
    completionHandler();
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (result) {
        // 其他如支付等SDK的回调
        return result;
    }
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [BullForceUpdateManager checkAppVersionIsNeedUpdate];//检查强制更新 创建完tabbar之后！！
    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
