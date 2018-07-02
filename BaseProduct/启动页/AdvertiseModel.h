//
//  AdvertiseModel.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/2.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertiseModel : NSObject
@property (nonatomic, copy) NSString *jump_target;//跳转目标，（闪频图：链接路径；首页推荐图：商品id ）
@property (nonatomic, copy) NSString *picture;//图片
@property (nonatomic, copy) NSString *jump_type;//斗牛tv跳转商城跳转位置 （ 1.商城首页 2.商品详情 ）
//闪屏图（0：不跳 1：跳转url ）
@property (nonatomic, assign) NSInteger is_show;//首页推荐图是否展示 （1展示 0不展示） 闪频图不用

//为广告新加的两个字段
@property (nonatomic, copy) NSString *picture_ori_name;//图片名称（保存名称）广告！
@property (nonatomic, assign) NSInteger gif_tag;//只有闪屏图有用 0：不是gif图 1：是gif图
@end
