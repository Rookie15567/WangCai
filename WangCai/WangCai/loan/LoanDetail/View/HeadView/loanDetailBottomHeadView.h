//
//  loanDetailBottomHeadView.h
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickFrameView.h"
#import "LoanDetailModel.h"
@protocol PickClickDelegate;

@interface loanDetailBottomHeadView : UIView
@property (strong, nonatomic) IBOutlet YYLabel *oneLabel;
@property (strong, nonatomic) IBOutlet PickFrameView *onePickView;
@property (strong, nonatomic) IBOutlet YYLabel *twoLabel;
@property (strong, nonatomic) IBOutlet PickFrameView *twoPickView;
@property (strong, nonatomic) IBOutlet YYLabel *moneyLabel;
@property (strong, nonatomic) IBOutlet YYLabel *moneyNameLabel;
@property (strong, nonatomic) IBOutlet YYLabel *rateLabel;
@property (strong, nonatomic) IBOutlet YYLabel *rateNameLabel;
@property (strong, nonatomic) IBOutlet YYLabel *speedLabel;
@property (strong, nonatomic) IBOutlet YYLabel *speedNameLabel;

@property (strong,nonatomic) NSString * oneString;//金额
@property (nonatomic,strong) NSString * twoString;//月份
@property (nonatomic,weak)id<PickClickDelegate>delegate;
-(void)changData:(LoanDetailModel*)model;
@end
@protocol PickClickDelegate <NSObject>

-(void)pickLoanVCClickAndType:(pickType)type ClickString:(NSString*)string;

@end
