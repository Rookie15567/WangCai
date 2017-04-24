//
//  LoanDetailHeadView.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanDetailHeadView.h"
#define BOTTOM_H 116
@implementation LoanDetailHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        if(!_topView){
            _topView = [[loanDetailHeadTopView alloc]initWithFrame:CGRectMake(0, 0, S_W, BOTTOM_H*K_S_H)];
            
            [self addSubview:_topView];
        }
        if(!_bottomView){
            _bottomView = [[loanDetailBottomHeadView alloc]initWithFrame:CGRectMake(0, BOTTOM_H*K_S_H, S_W, frame.size.height-BOTTOM_H*K_S_H)];
            _bottomView.delegate = self;
            
            [self addSubview:_bottomView];
        }
    }
    return self;
}
-(void)pickLoanVCClickAndType:(pickType)type ClickString:(NSString *)string
{
    if(type == pickOne){
        NSLog(@"%@",string);
    }else if (type == pickTwo){
        NSLog(@"%@",string);
    }
}
-(void)setData:(LoanDetailModel*)model{
    [_topView setData:model];//加载数据
    [_bottomView changData:model];//加载数据
}
@end
