//
//  loanView.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loanButtonView.h"
@class PickFrameView;
@interface loanView : UIView<LoanButtonDelagate>
@property (nonatomic,strong) PickFrameView * changePick;
@property (nonatomic,strong)YYLabel * loanLabel;
@property (nonatomic,strong) UIButton * pickButton;
@property (nonatomic,strong) loanButtonView * oneButton;
@property (nonatomic,strong) loanButtonView * twoButton;
@property (nonatomic,strong) loanButtonView * threeButton;
@property (nonatomic,strong) loanButtonView * fourButton;
@property (nonatomic,strong) void (^butBlock)(NSString* tag);
@end
