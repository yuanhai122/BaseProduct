//
//  KeyChainDataManager.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/9.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "KeyChainDataManager.h"
#import "KeyChain.h"
#define IsStringValid(text) (text && text!=NULL && text.length>0)

@implementation KeyChainDataManager

static NSString * const KEY_IN_KEYCHAIN_UUID = @"唯一识别的KEY_UUID";
static NSString * const KEY_UUID = @"唯一识别的key_uuid";

+(void)saveUUID:(NSString *)UUID{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    [KeyChain save:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

+ (NSString *)readUUID{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeyChain load:KEY_IN_KEYCHAIN_UUID];
    return [usernamepasswordKVPair objectForKey:KEY_UUID];
}

+(void)deleteUUID{
    [KeyChain delete:KEY_IN_KEYCHAIN_UUID];
}

+ (NSString *)UUID {
    NSString *devideID = [self getIdfaString];
    if (IsStringValid(devideID)) {
        return devideID;
    }else {
        devideID = [self getUUID];
        [self setIdfaString:devideID];
        if (IsStringValid(devideID)) {
            return devideID;
        }
    }
    return nil;
}

+ (NSString*)getIdfaString {
    NSString *idfaStr = [KeyChain load:IDFA_STRING];
    if (IsStringValid(idfaStr)) {
        return idfaStr;
    }else {
        return nil;
    }
}

#pragma mark - UUID
+ (NSString*)getUUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (!IsStringValid(uuid))
    {
        uuid = @"";
    }
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (BOOL)setIdfaString:(NSString *)secValue{
    if (IsStringValid(secValue))
    {
        [KeyChain save:IDFA_STRING data:secValue];
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
