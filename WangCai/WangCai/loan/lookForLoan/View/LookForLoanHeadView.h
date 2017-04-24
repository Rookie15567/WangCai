//
//  LookForLoanHeadView.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickFrameView.h"

@protocol PickClickDelegate;



@interface LookForLoanHeadView : UIView
@property (nonatomic,strong) YYLabel * oneLabel;
@property (nonatomic,strong) YYLabel * twoLabel;
@property (nonatomic,strong) PickFrameView * onePick;
@property (nonatomic,strong) PickFrameView * twoPick;
@property (nonatomic,strong) NSString * selectmnum;
@property (nonatomic,strong) NSString * selectRmbNum;
@property (nonatomic,weak)id<PickClickDelegate>delegate;

@end
@protocol PickClickDelegate <NSObject>

-(void)pickClickAndType:(pickType)type ClickString:(NSString*)string;

@end
