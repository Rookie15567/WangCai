//
//  LoanViewBaseHeader.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiseView.h"
#import "loanView.h"
#import "menuView.h"
#import "ScrollHeadView.h"
#import "LoanModel.h"
@protocol headViewDelegate;
typedef NS_OPTIONS(NSUInteger, HeadClickType) {
    HeadScrollView = 0,
    HeadADView = 1,
    HeadMenuView = 2,
    HeadLoanView = 3
};
@interface LoanViewBaseHeader : UIView <ScrollViewDelegate>
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)ScrollHeadView * scrollView;
@property (nonatomic,strong)menuView * menuView;
@property (nonatomic,strong)AdvertiseView * adverView;
@property (nonatomic,strong)loanView * loanView;
@property (nonatomic, strong) UIImageView *noticeImageView;
@property (nonatomic,weak)id<headViewDelegate>delegate;
@property (nonatomic,strong)NSArray * scrollerArr;
@property (nonatomic,strong)LoanModel * model;
@property (nonatomic,strong)NSArray * adArray;

-(void)setData:(NSArray * )imageArray;
-(void)scrollView:(NSArray* )urlArray;

@end
@protocol headViewDelegate <NSObject>
-(void)headViewOnClickType:(HeadClickType )type Str:(NSString *)string;
@end
