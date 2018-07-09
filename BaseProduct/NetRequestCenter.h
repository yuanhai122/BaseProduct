//
//  NetRequestCenter.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/9.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestBlock_Success) (id responseObject);
typedef void(^RequestBlock_Failed)(NSError *error);
@interface NetRequestCenter : NSObject
+ (instancetype)manager;


/**
 新-Post请求
 
 @param url 域名+接口名
 @param parameters 参数
 @param success success
 @param failed failed
 */
- (void)postRequestWithUrl:(NSString*)url
                parameters:(NSDictionary*)parameters
       completeWithSuccess:(RequestBlock_Success)success
                    failed:(RequestBlock_Failed)failed;


/**
 新-Get请求
 
 @param url 域名+接口名
 @param parameters 参数
 @param success success
 @param failed failed
 */
- (void)getRequestWithUrl:(NSString*)url
               parameters:(NSDictionary*)parameters
      completeWithSuccess:(RequestBlock_Success)success
                   failed:(RequestBlock_Failed)failed;
@end
