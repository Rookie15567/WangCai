//
//  RequestHelp.h
//  WangCai
//
//  Created by cds on 16/12/12.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <Foundation/Foundation.h>
//域名
#define primAPI @"https://www.5iwangcai.com"

//图片的地址是API加请求结果
#define SetImageUrl @""

//系统信息
#define SYSINFO @"/api/if/sysinfo"
//发送短信
#define SENDPED @"/api/if/sendpwd"
//用户登录
#define LOGIN @"/api/if/login"
//用户信息修改
#define EDITUSERINFO @"/api/if/edituserinfo"
//用户的借款记录
#define OUTMONEYLIST @"/api/if/getuoutmoneylist"
//主页
#define HOME @"/api/if/homebannerlist"
//主页三个
#define HOMEAD @"/api/if/homeadlist"
//银行列表
#define BACKLIST @"/api/if/homebanklist"
//借款列表
#define HOMEMEONEYLIST @"/api/if/homebmoneylist"
//信用卡申请记录
#define UCARDLIST @"/api/if/getucardlist"
//首页到h5
#define HOMELISTH5 @"/api/if/homebannerlist"
//银行卡列表
#define HOMEBANKLIST @"/api/if/homebanklist"
//信用卡列表
#define HOMECARDLIST @"/api/if/homecardlist"
//借款详情
#define MONEY_ID @"/api/if/getbmoneybyid"
//银行详情
#define BANK_ID @"/api/if/getbankbyid"
//根据id获取详情
#define CARD_ID @"/api/if/getcardbyid"
//用户查询借款
#define SEARCH_USER_MONEY @"/api/if/searchbmoneylist"
//借款成功
#define OK_MONEY @"/api/if/okbmoney"
//信用卡成功
#define OK_CARD @"/api/if/okcard"
//用户点击日志
#define CLICK_LOG @"/api/if/clicklog"
//上传图片
#define UP_LOAD @"/api/if/uploadfile"
@interface RequestHelp : NSObject
typedef NS_OPTIONS(NSUInteger, userCliclType) {
    userCliclTypeLoan = 0, //值为1 借款
    userCliclTypeCard = 1, //2 信用卡
    userCliclTypeBanner = 2,//3 banner
    userCliclTypeSearch = 3,//4 搜索
    userCliclTypeBank = 4// 5 银行
};

/**
 确定当前系统是审核还是审核后

 @return 返回yes 不成功 no 成功
 */
+(BOOL)systemIsBlock:(void (^)(id datt))block;
/**
 用户借款成功
 */
+(void)userLoanSucceedmnum:(NSString*)mnum rmbNum:(NSString*)tmbnum pid:(NSString*)pid;
/**
 用户点击日志

 @param type 类型 1
 @param pid  点击的id
 */
+(void)userClickLogType:(userCliclType)type andPid:(NSString *)pid Block:(void (^)(id datt))block;

//请求带缓存
+(void)PostRequestWithParameters:(id)parametes RequestString:(NSString*)requestString  dataBaseKey:(NSString*)key Block:(void (^)(id datt))block;
//请求不带缓存

/**
 不带缓存的请求

 @param parametes     上传表单
 @param requestString url
 @param block         返回数据
 */
+(void)PostRequestWithParameters:(id)parametes RequestString:(NSString*)requestString  Block:(void (^)(id datt))block;

+(void)UpdataImage:(UIImage *)image withUrl:(NSString*)urlString;

/**
 GET

 @param url   url
 @param block block回调
 */
+(void)GETquestWithUrl:(NSString*)url Block:(void (^) (id datt))block;
/**
 根据月份钱数查询

 @param mnum  月数
 @param rmb   钱数
 @param block Block回调
 */
+(void)searchBymNum:(NSString *)mnum andRmbnum:(NSString*)rmb Block:(void(^) (id datt))block;

/**
 更新用户发信息

 @param image   头像
 @param nameStr 昵称
 @param block   回调
 */
+(void)uploadUserHeadImage:(UIImage*)image Name:(NSString*)nameStr Block:(void(^) (id datt))block;

@end
