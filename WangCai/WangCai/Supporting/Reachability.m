//
//  Reachability.m
//  WangCai
//
//  Created by cds on 16/12/13.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "Reachability.h"

@implementation Reachability

+(NSArray*)sequenceBysort:(NSString*)sort dataDict:(NSArray *)array{
    NSMutableArray * marr = [NSMutableArray array];
    for (NSDictionary * dcit in array) {
        [marr addObject:dcit[sort]];
    }
    NSMutableArray * aaa = [NSMutableArray array];
    for(int i=0;i<array.count;i++){
        
    }
    return aaa;
}

+(NSString*)versionString{
    CGFloat k = [CFBundleVersion floatValue];
    NSLog(@"kkkkk%f",k);
    return [NSString stringWithFormat:@"%.0f",k*100];
}
+(void)afn{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [manger startMonitoring];
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
}
+(BOOL)isReachability
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
          
        }else{
          
        }
    }];
   NSString* str = [reachabilityManager localizedNetworkReachabilityStatusString];
    NSLog(@"str === %@",str);
    return YES;
}

/**
 保存userid

 @param userid userid
 */
+(void)saveUserid:(NSString *)userid{
   NSString * date= [self dateFormatterDate:DATEFOEMAT];
    [NSUSERDEF setObject:@{USER_ID:userid,@"time":date} forKey:LOGIN_USER_ID];
    NSUSERDEF_SYN;
}

/**
 保存Token

 @param token Token
 */
+(void)saveToken:(NSString *)token{
    NSString * date= [self dateFormatterDate:DATEFOEMAT];
    [NSUSERDEF setObject:@{USER_TOKEN:token,@"time":date} forKey:LOGIN_USER_TOKEN];
    NSUSERDEF_SYN;
}

/**
 退出登录清除信息
 */
+(void)leaveLogin
{
    [NSUSERDEF setObject:nil forKey:LOGIN_USER_ID];
    [NSUSERDEF setObject:nil forKey:LOGIN_USER_TOKEN];
    NSUSERDEF_SYN;
}
//读取id
+(NSString *)userId
{
    if([NSUSERDEF valueForKey:LOGIN_USER_ID] == nil)
        return @"0";
    else
    return [NSUSERDEF valueForKey:LOGIN_USER_ID][USER_ID];
}
/**
 读取Token

 @return toekn
 */
+(NSString *)token
{
    if([NSUSERDEF valueForKey:LOGIN_USER_TOKEN] == nil)
        return @"";
    else
        return [NSUSERDEF valueForKey:LOGIN_USER_TOKEN][USER_TOKEN];
/**
 判断是否需要登录

 @param BOOL yes or no

 @return yes 需要登录
 */
}
+(BOOL)isNeedLogin
{
    /*读取信息*/
    NSDictionary * nlogin = [NSUSERDEF valueForKey:LOGIN_USER_ID];
    if(nlogin == nil){
       return YES;
    }else{
        NSInteger  oldTime = [nlogin[@"time"] integerValue]; //保存用户数据的数据
        NSInteger newTime =  [[self dateFormatterDate:DATEFOEMAT] integerValue]; //当前时间
        if(newTime - oldTime > Login_limit ){
            //重新登录 清除用户信息
            [self leaveLogin];
            return YES;
        }else{
            //修改时间
            NSString * date= [self dateFormatterDate:@"yyMMdd"];
            [NSUSERDEF setObject:@{USER_ID:[NSUSERDEF valueForKey:LOGIN_USER_ID][USER_ID],@"time":date} forKey:LOGIN_USER_ID];
            [NSUSERDEF setObject:@{USER_TOKEN:[NSUSERDEF valueForKey:LOGIN_USER_TOKEN][USER_TOKEN],@"time":date} forKey:LOGIN_USER_TOKEN];
            NSUSERDEF_SYN;
            return NO;
        }
    }
}

/**
 时间戳转化字符串

 @param Forma 格式 yyMMdd

 @return 时间字符串
 */
+(NSString*)dateFormatterDate:(NSString*)Forma{
    NSDateFormatter *dateForma = [[NSDateFormatter alloc] init];
    [dateForma setDateFormat:Forma];
    NSString *strDate = [dateForma stringFromDate:[NSDate date]];
    return strDate;
}

/**
 保存图片

 @param fileName  文件名
 @param saveImage 图片
 */
+(void)saveDiskSandBy:(NSString*)fileName image:(UIImage *)saveImage
{
    NSFileManager * fileManage = [NSFileManager defaultManager];
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docum = [path objectAtIndex:0];
    NSString * mydic = [docum stringByAppendingPathComponent:@"userImage"];
    NSString * filePath = [mydic stringByAppendingPathComponent:[NSString stringWithFormat:@"userImage.png"]];
    NSLog(@"documentsDirectory%@======%@",filePath,NSHomeDirectory());
    NSLog(@"time == %@",filePath);
    [UIImagePNGRepresentation(saveImage)writeToFile:filePath atomically:YES];
    [fileManage createDirectoryAtPath:mydic withIntermediateDirectories:YES attributes:nil error:nil];
    
}

/**
 获取图片

 @param fileName 文件名

 @return 图片
 */
+(UIImage*)obtainUserHeadImage:(NSString*)fileName{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docum = [path objectAtIndex:0];
    NSString * mydic = [docum stringByAppendingPathComponent:@"userImage"];
    NSString * filePath = [mydic stringByAppendingPathComponent:[NSString stringWithFormat:@"userImage.png"]];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        return image;
    }
    return nil;
}
@end
