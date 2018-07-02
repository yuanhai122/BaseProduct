//
//  macro.h
//  BaseProduct
//
//  Created by zfxf on 2018/7/2.
//  Copyright © 2018年 袁海. All rights reserved.
//

#ifndef macro_h
#define macro_h

//iPhone X 适配
#define IS_IPHONE_X (UISCREEN_HEIGHT == 812.0f) ? YES : NO
#define Height_NavContentBar 44.0f
#define Height_StatusBar (IS_IPHONE_X==YES)?44.0f: 20.0f
#define Height_NavBar (IS_IPHONE_X==YES)?88.0f: 64.0f
#define Height_TabBar (IS_IPHONE_X==YES)?83.0f: 49.0f
#define Height_TabbarSafeBottom (IS_IPHONE_X==YES)?34.0f: 0.0f

#define WeakSelf(weakSelf) __weak typeof(self) weakSelf = self;

/**
 屏幕宽
 */
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**
 屏幕高
 */
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#endif /* macro_h */
