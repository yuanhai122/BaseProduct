//
//  NSDictionary+Category.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/10.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
