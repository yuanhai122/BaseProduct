//
//  KeyChainDataManager.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/9.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IDFA_STRING @"com.zfxf.douniu.uuid"

@interface KeyChainDataManager : NSObject
/**
 *   存储 UUID
 *
 *     */
+(void)saveUUID:(NSString *)UUID;

/**
 *  读取UUID *
 *
 */
+(NSString *)readUUID;

/**
 *    删除数据
 */
+(void)deleteUUID;

/**
 *    UUID
 *
 *     */
+ (NSString*)UUID;
@end
