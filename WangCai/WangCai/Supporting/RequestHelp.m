//
//  RequestHelp.m
//  WangCai
//
//  Created by cds on 16/12/12.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "RequestHelp.h"
#import <AFNetworking.h>
@implementation RequestHelp

//+ (AFSecurityPolicy *)customSecurityPolicy
//{
//    //先导入证书，找到证书的路径
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"Admin" ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    
//    //AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    
//    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    //如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
//    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
//    securityPolicy.pinnedCertificates = set;
//    
//    return securityPolicy;
//}
+(void)PostRequestWithParameters:(id)parametes RequestString:(NSString*)requestString  Block:(void (^)(id datt))block
{
   
    if((1)){
       UIView* iew = [UIApplication sharedApplication].keyWindow;
         MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:iew animated:YES];
       NSLog(@"上传表单 === %@",parametes);
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       // manager.responseSerializer = [AFJSONResponseSerializer serializer];
       // manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript",@"text/html",@"text/plain", nil];
      NSString * url =  [NSString stringWithFormat:@"%@%@",primAPI,requestString];
        [manager POST:url parameters:parametes progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress = %@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            //NSLog(@"%@===",dict);
            block(dict);
            
            [mbp hideAnimated:YES];
            [mbp hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [mbp hideAnimated:YES];
            [MBProgressHUD showWithText:@"请求失败" view:nil];
            NSLog(@"%@ ---  ",error);
            
            
        }];
    }else{
        
        [MBProgressHUD showWithText:@"网络不佳" view:nil];
    }
}

/**
 用户点击日志

 @param type  类型
 @param pid   类型的id
 @param block 回调
 */
+(void)userClickLogType:(userCliclType)type andPid:(NSString *)pid Block:(void (^)(id datt))block
{
    NSString * typeStr;
    switch (type) {
        case userCliclTypeLoan:
        {//借款
            typeStr = @"1";
            break;
        }
        case userCliclTypeCard:
        {//信用卡
            typeStr = @"2";
            break;
        }
        case userCliclTypeBanner:
        {
            typeStr = @"3";
            break;
        }
        case userCliclTypeSearch:
        {
            typeStr = @"4";
            break;
        }
        case userCliclTypeBank:
        {
            typeStr = @"5";
            break;
        }
        default:
            break;
    }
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"type":typeStr,@"pid":pid};
    [RequestHelp PostRequestWithParameters:dict RequestString:CLICK_LOG
                                     Block:^(id datt) {
                                         NSLog(@"search%@",datt);
                                         if([datt[@"code"] isEqualToString:@"0000"]){
                                             block(datt);
                                         }
                                     }];
}

+(void)PostRequestWithParameters:(id)parametes RequestString:(NSString*)requestString  dataBaseKey:(NSString*)key Block:(void (^)(id datt))block
{
    if([Reachability isReachability]){
       // MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:nil animated:YES];
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    manager.requestSerializer.timeoutInterval = 5;
    //[manager setSecurityPolicy:[self customSecurityPolicy]];
    [manager POST:@"http://115.159.25.11/yxs/cms/webinface!ringACT.action?" parameters:parametes constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"formData == %@",formData);
         //[mbp hideAnimated:YES];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@",uploadProgress);
        //[mbp hideAnimated:YES];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
        NSLog(@"responseObject == %@",responseObject);
       // [mbp hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         //[mbp hideAnimated:YES];
        [MBProgressHUD showWithText:@"请求失败" view:nil];
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        NSLog(@"Failure error serialised - %@",serializedData);
    }];
    }else{
        [MBProgressHUD showWithText:@"网络不佳" view:nil];
    }
}

+(void)searchBymNum:(NSString *)mnum andRmbnum:(NSString*)rmb Block:(void(^) (id datt))block{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"mnum":mnum,@"rmbnum":rmb};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:SEARCH_USER_MONEY
                                     Block:^(id datt) {
                                         NSLog(@"search%@",datt);
                                         if([datt[@"code"] isEqualToString:@"0000"]){
                                             block(datt);
                                         }
                                     }];
}
+(void)GETquestWithUrl:(NSString*)url Block:(void (^) (id datt))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript",@"text/html",@"text/plain", nil];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"string  == %@",string);
        block(string);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+(void)UpdataImage:(UIImage *)image withUrl:(NSString *)urlString
{
    
}
+(void)userLoanSucceedmnum:(NSString *)mnum rmbNum:(NSString *)tmbnum pid:(NSString *)pid
{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"mnum":mnum,@"rmbnum":tmbnum,@"pid":pid};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:OK_CARD
                                     Block:^(id datt) {
                                         NSLog(@"search%@",datt);
                                         if([datt[@"code"] isEqualToString:@"0000"]){
//                                             block(datt);
                                         }
                                     }];
}
+(void)uploadUserHeadImage:(UIImage *)image Name:(NSString *)nameStr Block:(void (^)(id))block
{
    if(!image){
        image = [UIImage imageNamed:@"text"];
    }
    if(!nameStr){
        nameStr = @"";
    }
        NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"face":image,@"name":nameStr};
    [RequestHelp PostRequestWithParameters:dict RequestString:EDITUSERINFO
                                     Block:^(id datt) {
                                        
                                         if([datt[@"code"] isEqualToString:@"0000"]){
                                             block(datt);
                                         }
                                     }];
}
+(BOOL)systemIsBlock:(void (^)(id))block
{
    NSDictionary * dict = @{@"userid":@"0",@"token":@"",@"version":PHONE_VERSION};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:SYSINFO
                                     Block:^(id datt) {
                                         //NSLog(@"sys == %@",datt);
                                         if([datt[@"code"] isEqualToString:@"0000"]){
                                                                                          block(datt);
                                            
                                         }
                                     }];
    return YES;
}
@end
