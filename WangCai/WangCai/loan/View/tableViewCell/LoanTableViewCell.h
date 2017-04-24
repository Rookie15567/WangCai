//
//  LoanTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanMainCellModel.h"
@interface LoanTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * contenImageView;
@property (nonatomic,strong)YYLabel * typeLabel; //类型
@property (nonatomic,strong)YYLabel * peopleLabel;//申请人数
@property (nonatomic,strong)YYLabel * numLabel; //人数
@property (nonatomic,strong)YYLabel * limitLabel;//额度
@property (nonatomic,strong)YYLabel * rateLabel;//月利率
@property (nonatomic,strong)YYLabel * rateNumLabel;//利率
@property (nonatomic,strong) UIImageView * lineImage;
@property (nonatomic,strong)LoanMainCellModel * model;
-(void)setDataSource:(LoanMainCellModel *)model;
@end
