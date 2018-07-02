//
//  NSString+Category.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/2.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (BOOL)isBlankString:(NSString *)str{
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
