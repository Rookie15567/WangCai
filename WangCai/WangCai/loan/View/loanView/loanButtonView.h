//
//  loanButtonView.h
//  WangCai
//
//  Created by cds on 16/12/12.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoanButtonDelagate;
@interface loanButtonView : UIView
@property (nonatomic,strong)YYLabel * rightLabel;
@property (nonatomic,strong)YYLabel * leftLabel;
@property (nonatomic,strong)UIView * backView;
-(void)changDataRightString:(NSString *)right leftString:(NSString*)left;
@property (nonatomic,weak)id <LoanButtonDelagate>delegate;
@end
@protocol LoanButtonDelagate <NSObject>

-(void)tapClick:(UIView*)view;

@end
