//
//  trendHeadView.h
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CardPosition) {
    CardPositionRight = 0,
    CardPositionLeft = 1,
};
@interface trendHeadView : UIView
@property(nonatomic,strong) UIImageView * cardImageView;
@property (nonatomic,strong)YYLabel * titleLabel;
@property (nonatomic,strong) YYLabel * label;
@property (nonatomic,strong)YYLabel * detailLabel;
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic,strong)void (^trendBlock)(NSInteger num);
-(void)isShowTitle:(BOOL)isShow position:(CardPosition)position;
@end
