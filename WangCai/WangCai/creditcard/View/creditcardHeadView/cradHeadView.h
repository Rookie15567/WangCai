//
//  cradHeadView.h
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "trendHeadView.h"
#import "CredCardModel.h"
typedef enum {
    headTopImg = 0,
    headTrendOne,
    headTrendTwo
}headSelectType;
#define BANNER_H 100
@protocol headDelegate;

@interface cradHeadView : UIView
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UIImageView * oneReCardImageView;
@property (nonatomic,strong)UIImageView * twoReCardImageView;
@property (nonatomic,strong)UIImageView * oneLineImageView;
@property (nonatomic,strong)UIImageView * twoLineImageView;
@property (nonatomic,strong)YYLabel * trendLabel;
@property (nonatomic,strong)YYLabel * oneLabel;
@property (nonatomic,strong)YYLabel * oneDetailLabel;
@property (nonatomic,strong)YYLabel * twoLabel;
@property (nonatomic,strong)YYLabel * twoDetailLabel;
@property (nonatomic,strong) trendHeadView * oneTrned;
@property (nonatomic,strong)trendHeadView * twoTrend;
@property (nonatomic,strong) UIImageView * barnnerImg;
@property (nonatomic,weak)id <headDelegate>delegate;

-(void)setData:(NSArray*)model;
@end
@protocol headDelegate <NSObject>

-(void)headViewSelectType:(headSelectType)type;

@end
