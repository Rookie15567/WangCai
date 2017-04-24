//
//  Reachability.h
//  WangCai
//
//  Created by cds on 16/12/13.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Reachability.h"
typedef NS_OPTIONS(NSUInteger, ReachabilityType) {
    ReachabilityTypeNOT = 0,
    ReachabilityTypeYES = 1
};
@interface Reachability : NSObject

#define LOGIN_USER_ID @"userInfoid"
#define USER_ID @"userid"

#define LOGIN_USER_TOKEN @"userToken"
#define USER_TOKEN @"token"

#define DATEFOEMAT @"yyMMdd" //年月日

#define PHONE_USERID [Reachability userId] //获取userid
#define PHONE_TOKEN [Reachability token]//获取token
#define PHONE_VERSION [Reachability versionString]  //版本号



+(NSArray*)sequenceBysort:(NSString*)sort dataDict:(NSArray*)array;

/**
 获取系统版本号

 @return 版本号
 */
+(NSString*)versionString;
    
+(void)afn;
/**
 网络监测

 @return 是否有网
 */

+(BOOL)isReachability;

//游客 用户
+(void)leaveLogin;
/**
 是否需要登录

 */
+(BOOL)isNeedLogin;
/**
 保存用户id
 */
+(void)saveUserid:(NSString*)userid;

/**
 获取userid

 @return 用户id
 */
+(NSString *)userId;

/**
 保存Token
 */
+(void)saveToken:(NSString*)token;

/**
 获取token

 @return token
 */
+(NSString*)token;

/**
 时间戳转字符串

 @param Forma 格式@"yyyy-MM-dd HH:mm:ss"

 @return 时间字符串
 */
+(NSString*)dateFormatterDate:(NSString*)Forma;
/**
 本地保存图片

 @param fileName  文件名 暂时设nil
 @param saveImage 需要保存的图片
 */
+(void)saveDiskSandBy:(NSString*)fileName image:(UIImage *)saveImage;
/**
 根据文件名读取本地保存的图片

 @param fileName 文件名

 @return 返回图片
 */
+(UIImage*)obtainUserHeadImage:(NSString*)fileName;
@end
