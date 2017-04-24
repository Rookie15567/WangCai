//
//  LoanDetailViewController.h
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BasePopViewController.h"
#import "LoanDetailModel.h"
@interface LoanDetailViewController : BasePopViewController
@property (nonatomic,strong)NSString * pid; //获取详情的pid
@property (nonatomic,strong) NSDictionary * buffDict;//暂存数据字典 
@end
