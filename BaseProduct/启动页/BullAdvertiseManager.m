//
//  BullAdvertiseManager.m
//  TheBull
//
//  Created by 郭达 on 2018/5/22.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "BullAdvertiseManager.h"
#import "AdvertiseModel.h"

@interface BullAdvertiseManager ()

@property (nonatomic, strong) GDAdvertiseView *advertiseView;
@property (nonatomic, strong) NSTimer *gdtimer;
@property (nonatomic, assign) NSInteger total_Time;


@end
@implementation BullAdvertiseManager

+(instancetype)defaultManager {
    static BullAdvertiseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (void)handle_AdvertiseWithSuperWindow:(UIWindow*)rootwindow {
    AdvertiseModel *localModel = [self readAdSource];
    if (!localModel) {//如果木有，直接跳过广告，进tabbar 并且去请求下载新的
        [self gd_newRequestAdWithOldAdName:nil isNeedDownload:YES];
        return;
    }
    //model里有数据，找本地是否有img数据
    NSData *localImgData = [self readPicturedataWithName:localModel.picture_ori_name];
    if (!localImgData) {
        [self gd_newRequestAdWithOldAdName:localModel.picture_ori_name isNeedDownload:YES];
        return;
    }
    
    //本地有数据，那就显示广告   以后model中有endtime 再判断时间
    _total_Time = 3;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    _advertiseView = [[GDAdvertiseView alloc] initWithFrame:window.bounds];
    [window addSubview:_advertiseView];
    [window bringSubviewToFront:_advertiseView];
    _advertiseView.timerLabel.text = [NSString stringWithFormat:@"跳过%ld",_total_Time];

    [_advertiseView updateImgDataswith:localImgData andSourceName:localModel];

    WeakSelf(weakSelf)
    _advertiseView.skipAdViewBlock = ^{//跳过
        [weakSelf shutdownTimer];
        [weakSelf removeAdViewwithTime:0.3];
    };
    //点击去详情
    _advertiseView.goAdDetailBlock = ^{
        [weakSelf tapAdvertiseViewToDetailWithLocalModel:localModel];
    };
    
    
    [self createTimer];

    [self gd_newRequestAdWithOldAdName:localModel.picture_ori_name isNeedDownload:NO];

}
- (void)tapAdvertiseViewToDetailWithLocalModel:(AdvertiseModel *)model {
    if ([model.jump_type isEqualToString:@"0"]) {
        //不跳
        NSLog(@"广告不跳详情 type=0");
    }else if ([model.jump_type isEqualToString:@"1"]){
//        [FirstHomeManager go_H5VC:[GlobleConst gd_currentViewController] urlstring:model.data.jump_target];
    }
    //去掉广告
    [self shutdownTimer];
    [self removeAdViewwithTime:0.3];
    
}

- (void)createTimer {
    if (!_gdtimer) {
        _gdtimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDown) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_gdtimer forMode:NSRunLoopCommonModes];
    }
}
- (void)timerDown {
    _total_Time -= 1;
    
    if (_advertiseView != nil) {
        _advertiseView.timerLabel.text = [NSString stringWithFormat:@"跳过%ld",_total_Time];
    }
    if (_total_Time <= 0) {
        [self shutdownTimer];
        [self removeAdViewwithTime:0.3];
    }
    
}
- (void)shutdownTimer {
    if (_gdtimer) {
        [_gdtimer invalidate];
        _gdtimer = nil;
    }
}
- (void)removeAdViewwithTime:(NSTimeInterval)time {
    if (!_advertiseView) {
        return;
    }
    self.advertiseView.userInteractionEnabled = NO;
    [UIView animateWithDuration:time animations:^{
        self.advertiseView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.advertiseView != nil) {
            [self.advertiseView removeFromSuperview];
            self.advertiseView = nil;
        }
    }];
    
}
//请求model
- (void)gd_newRequestAdWithOldAdName:(NSString*)oldName isNeedDownload:(BOOL)isNeed {
//    WeakSelf(weakSelf)
//    [FuCengManager fuCengNetRequest_WithsourceType:FucengSourceType_Advertise IsHaveTimeInterval:NO     completeWithSuccess:^(AdvertiseModel *fcModel) {
//        //yh_310033
//        [weakSelf saveAdSourceWithModel:fcModel];
//        if (![fcModel.data.picture_ori_name isEqualToString:oldName] || isNeed) {
//            [weakSelf downloadImgSourceWithName:fcModel andOldName:oldName];
//        }
//    } failed:^{
//
//    }];
    
}

- (NSString *)getlocaldirectory {
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString*libpath = [paths objectAtIndex:0];
    NSString *Directory = [NSString stringWithFormat:@"%@/Bullcache",libpath];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL yes;
    if (![manager fileExistsAtPath:Directory isDirectory:&yes]) {
         [manager createDirectoryAtPath:Directory withIntermediateDirectories:yes attributes:nil error:nil];
    }
    if (yes) {
        return Directory;
    }
    return nil;
}
#pragma mark - 保存model
- (BOOL)saveAdSourceWithModel:(AdvertiseModel *)model{
    NSString *savePath = [NSString stringWithFormat:@"%@/gdadvertise",[self getlocaldirectory]];
    BOOL b = [NSKeyedArchiver archiveRootObject:model toFile:savePath];
    return b;
}
#pragma mark - 读取model
- (AdvertiseModel *)readAdSource {
    NSString *savePath = [NSString stringWithFormat:@"%@/gdadvertise",[self getlocaldirectory]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
        AdvertiseModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
        return model;
    }
    return nil;
}
#pragma mark - 下载图片资源
- (void)downloadImgSourceWithName:(AdvertiseModel*)model andOldName:(NSString*)oldName{

    NSString *savePath = [NSString stringWithFormat:@"%@/%@",[self getlocaldirectory],model.picture_ori_name];
    //NSString *imageUrl  = [NSString stringWithFormat:@"%@%@",baseImageView_URL,name];
    NSString *imageUrl = model.picture;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        if (data.length > 0 && [data writeToFile:savePath atomically:YES]) {
            NSLog(@"广告图片保存成功");
            //删除之前的图片缓存
            if (![model.picture_ori_name isEqualToString:oldName]) {
                [self removeLocalOldImgCacheWithOldName:oldName];
            }
        }else NSLog(@"广告图片保存--失败");
    });
}
#pragma mark - 删除之前图片的本地缓存
- (BOOL)removeLocalOldImgCacheWithOldName:(NSString*)oldName{
    if (![NSString isBlankString:oldName]) return NO;
    
    NSString *oldPath = [NSString stringWithFormat:@"%@/%@",[self getlocaldirectory],oldName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL b = [fileManager removeItemAtPath:oldPath error:nil];
    if (b) NSLog(@"之前图片删除成功");
    return b;
}

#pragma mark - 读取本地的图片资源
- (NSData *)readPicturedataWithName:(NSString*)name {
    if (![NSString isBlankString:name]) return nil;
    
    NSString *savePath = [NSString stringWithFormat:@"%@/%@",[self getlocaldirectory],name];
    NSData *data = [[NSData alloc] initWithContentsOfFile:savePath];
    return data;
}

//- (NSString *)gd_base64EncodePictureName:(NSString*)name {
//    NSData *encodeData = [name dataUsingEncoding:NSUTF8StringEncoding];//NSDataBase64EncodingOptions
//    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
//    return base64String;
//}
//- (NSString *)gd_analysisServerImgName:(NSString*)name {
//    NSArray *arr = [name componentsSeparatedByString:@"?"];
//    if (arr.count > 0) {
//        return arr[0];
//    }
//    return nil;
//}
@end





#pragma mark - view
@interface GDAdvertiseView ()

@end
@implementation GDAdvertiseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.gifImgView];
        [self addSubview:self.timerLabel];
        [self bringSubviewToFront:self.timerLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifImgView.frame = self.bounds;
    self.timerLabel.frame = CGRectMake(UISCREEN_WIDTH - 70, Height_NavBar + 10, 60, 25);
}

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timerLabel.layer.cornerRadius = 13;
        _timerLabel.clipsToBounds = YES;
        _timerLabel.font = [UIFont systemFontOfSize:13];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        _timerLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        _timerLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipTapAction:)];
        [_timerLabel addGestureRecognizer:tap];
    }
    return _timerLabel;
}
- (void)skipTapAction:(UITapGestureRecognizer *)tap {
    if (self.skipAdViewBlock) {
        self.skipAdViewBlock();
    }
}

- (FLAnimatedImageView *)gifImgView {
    if (!_gifImgView) {
        _gifImgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectZero];
        _gifImgView.backgroundColor = [UIColor whiteColor];
        _gifImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTapAction:)];
        [_gifImgView addGestureRecognizer:tap];
    }
    return _gifImgView;
}
- (void)touchTapAction:(UITapGestureRecognizer *)tap {
    if (self.goAdDetailBlock) {
        self.goAdDetailBlock();
    }
}
- (void)updateImgDataswith:(NSData *)datasource andSourceName:(AdvertiseModel*)model {

    if (model.gif_tag == 1) {
        
        FLAnimatedImage *imgs = [[FLAnimatedImage alloc] initWithAnimatedGIFData:datasource];
        self.gifImgView.animatedImage = imgs;
    }else {
        self.gifImgView.image = [UIImage imageWithData:datasource];
    }

}
@end



