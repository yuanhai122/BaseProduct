//
//  ChangeLanguage.h
//  BaseProduct
//
//  Created by 袁海 on 2018/7/8.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeLanguage : NSObject

+(NSBundle *)bundle;//获取当前资源文件

+(void)initUserLanguage;//初始化语言文件

+(NSString *)userLanguage;//获取应用当前语言

+(void)setUserlanguage:(NSString *)language;//设置当前语言
@end
