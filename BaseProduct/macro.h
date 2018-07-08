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


#define RGBColor(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

// 计算比例
#define YHiPhone6W 375.0
#define YHiPhone6H 667.0
// x比例 1.293750 在iPhone7的屏幕上
#define YHScaleX UISCREEN_WIDTH / YHiPhone6W
// y比例 1.295775
#define YHScaleY UISCREEN_HEIGHT / YHiPhone6H
// X坐标
#define LineX(l) l*YHScaleX
// Y坐标
#define LineY(l) l*YHScaleY

//多语言
#define localizedString(key) [[ChangeLanguage bundle] localizedStringForKey:key value:nil table:@"English"]
#endif /* macro_h */
