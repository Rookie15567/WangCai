//
//  public.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#ifndef public_h
#define public_h

#import <YYKit.h>
#import <Masonry.h>
#import "RGBColor.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "Reachability.h"
#import "RequestHelp.h"
#import "BaseWebViewController.h"
#import <UMMobClick/MobClick.h>
#import "LoginViewController.h"
//用户7天不在线后需要重新登录
#define Login_limit 7

#define DISK_USER_APPLR @"applyInfo"

#define NSUSERDEF [NSUserDefaults standardUserDefaults]
#define NSUSERDEF_SYN [[NSUserDefaults standardUserDefaults] synchronize] 

#define S_W [UIScreen mainScreen].bounds.size.width
#define S_H [UIScreen mainScreen].bounds.size.height
#define K_S_W ([UIScreen mainScreen].bounds.size.width / 375)
#define K_S_H ([UIScreen mainScreen].bounds.size.height / 667)
//客服
#define APPKEFU_KEY @"d348fc1bef09c0cdd84b543abd822154"
#define DEMO_WOKGROUP_ID  @"wangcaikefu1"
//友盟
#define UMCLICK_KEY @"5870a8cef29d9869a8000661"
#define DEBUG 1
//#ifndef __OPTIMIZE__
//
//#define NSLog(...) NSLog(__VA_ARGS__)
//
//#else
//
//#define NSLog(...) {}
//
//#endif
// 带有RGB的颜色设置
#define kRGBColor(R, G, B)           [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define kRGBAColor(R, G, B, A)       [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define kRGBMainColor                kRGBColor(251, 112, 0)
#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]
#define scale__ (SCREEN_WIDTH/375.0)

//4和4s
#define IPHONE4_OR_4S (S_H <500)

//5和5s
#define IPHONE5_OR_5S (S_H ==568)

//6和6s 7
#define IPHONE6_OR_6S_OR_7 （S_W== 375）
//6plus 7p
#define IPHONE6sP_OR_6p_OR_7P (S_W == 414)
//6plus 7p
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
//系统判断
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOSVersion [[UIDevice currentDevice].systemVersion doubleValue]

//当前版本号
#define CFBundleVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])


#ifndef kNavigationBarHeight
#define kNavigationBarHeight 64.0
#endif

#ifndef kTabBarHeight
#define kTabBarHeight 49.0
#endif


//自定义字体[UIFont fontWithName:字体名字 size:size];
#ifndef TITLE_SELF_FONT
#define TITLE_SELF_FONT(__font__,__size__)\
[UIFont fontWithName:__font__ size:__size__]
#endif

#ifndef SYSTEM_FONT
#define SYSTEM_FONT(__fontsize__)\
[UIFont systemFontOfSize:__fontsize__]
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif

#ifndef NIB_NAMED
#define NIB_NAMED(__nibName__)\
[UINib nibWithNibName:__nibName__ bundle:nil]
#endif
#pragma mark - 全局
//保存用户信息Key
#define NSUSER_USER_INFO @"userInfo"

#define LINE_COLOR @"e5e5e5"
#define LINE_EEEEECOLOR @"EEEEEE"
//#define ALL_BLUE_COLOR @"00B2EE"
#define ALL_ENV_BLUE_COLOR @"33AEDA"
#define ALL_NAV_TITLE_COLOR @"FFFFFF"
#define ALL_NAV_TITLE_FONT 17

//#define ALL_NAV_TITLE_REGU (IOS9_OR_LATER? @"PingFangSC-Regular":@".PingFang-SC-Thin")//字体1
//#define ALL_NAV_TITLE_LIGHT (IOS9_OR_LATER?@"PingFangSC-LIGHT":@".PingFang-SC-Light")//字体2
#define ALL_NAV_TITLE_REGU @"Heiti SC"//字体1
#define ALL_NAV_TITLE_LIGHT @"Heiti SC"//字体2
//Heiti SC
#define TEST (IOS9_OR_LATER?@"wwwww":@"dfsdfsdf")


#pragma mark - 首页cell
#define TEXT_REDCOLOR @"FF3333"
#define TEXT_BLACKCOLOR @"333333"
#define TEXT_GARYCOLOR @"666666"
#define TEXT_PLCCCCCOLOR @"CCCCCC"
#define FONT_SMELL 13
#define FONT_GIB 15

#endif /* public_h */
