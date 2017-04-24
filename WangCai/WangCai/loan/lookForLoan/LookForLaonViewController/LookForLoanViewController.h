//
//  LookForLoanViewController.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "BasePopViewController.h"

@interface LookForLoanViewController : BasePopViewController
@property (nonatomic,strong)NSString * Mnum;
@property (nonatomic,strong)NSString * RMBnum;
@property (nonatomic,strong)NSString * speed;
@property (nonatomic,assign)BOOL isSpeed;
@property (nonatomic,strong) NSArray * idArray;
@end
