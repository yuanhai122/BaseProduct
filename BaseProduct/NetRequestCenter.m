//
//  NetRequestCenter.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/9.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "NetRequestCenter.h"

@interface NetRequestCenter ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation NetRequestCenter

+ (instancetype)manager {
    static NetRequestCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
        
        center.sessionManager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
        request.timeoutInterval = 30;
        center.sessionManager.requestSerializer = request;
        
        /*
         response ：
         1.AFHTTPResponseSerializer:返回的是Data流
         2.AFJSONResponseSerializer:返回的是字典，直接自动解析json，服务器传回的要严格的json格式
         */
        
        center.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        center.sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];//,@"text/plain"
        
    });
    return center;
}
//post请求
- (void)postRequestWithUrl:(NSString*)url
                parameters:(NSDictionary*)parameters
       completeWithSuccess:(RequestBlock_Success)success
                    failed:(RequestBlock_Failed)failed {
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    [self.sessionManager POST:url parameters:mutableDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
    
}
//get
- (void)getRequestWithUrl:(NSString*)url
               parameters:(NSDictionary*)parameters
      completeWithSuccess:(RequestBlock_Success)success
                   failed:(RequestBlock_Failed)failed {
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];

    [self.sessionManager GET:url parameters:mutableDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
    
}
@end
