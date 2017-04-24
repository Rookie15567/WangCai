//
//  loanDetailHeadTopView.h
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanDetailModel.h"
@interface loanDetailHeadTopView : UIView
@property (nonatomic,strong)UIImageView * tagImageView; //标题图片
@property (nonatomic,strong)YYLabel * nameLabel; //名字
@property (nonatomic,strong) YYLabel * peopleNum;//人数
@property (nonatomic,strong) YYLabel * success;//成功率
@property (nonatomic,strong) YYLabel * adLabel;//广告
@property (nonatomic,strong) UIImageView * lineImageView;//下划线

-(void)setData:(LoanDetailModel*)model;
@end
