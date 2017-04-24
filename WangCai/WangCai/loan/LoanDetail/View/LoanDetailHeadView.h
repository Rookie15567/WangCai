//
//  LoanDetailHeadView.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loanDetailHeadTopView.h"
#import "loanDetailBottomHeadView.h"
#import "LoanDetailModel.h"
@protocol headDelegate;
@interface LoanDetailHeadView : UIView<PickClickDelegate>

@property (nonatomic,strong)loanDetailHeadTopView * topView;
@property (nonatomic,strong)loanDetailBottomHeadView * bottomView;
@property (nonatomic,weak)id<headDelegate>delegate;
-(void)setData:(LoanDetailModel*)model;
@end
@protocol headDelegate <NSObject>

-(void)pickClick:(pickType)type str:(NSString*)string;

@end
