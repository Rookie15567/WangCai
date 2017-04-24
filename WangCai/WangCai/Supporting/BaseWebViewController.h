//
//  BaseWebViewController.h
//  WangCai
//
//  Created by cds on 16/12/28.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BasePopViewController.h"

@interface BaseWebViewController : BasePopViewController
@property (nonatomic,strong)NSString * baseUrl;
@property (nonatomic,assign)BOOL isDetail;
@property (nonatomic,strong) NSDictionary * buffDict;//暂存数据的字典
@property (nonatomic,strong) NSString * mnum;
@property (nonatomic,strong)NSString * rmbnum;
@end
