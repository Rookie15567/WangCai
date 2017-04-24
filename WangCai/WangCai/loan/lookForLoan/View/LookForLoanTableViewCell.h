//
//  LookForLoanTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanMainCellModel.h"
@interface LookForLoanTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * contenImageView;   //左侧图片
@property (nonatomic,strong)UIImageView * tagImageView; //标签图片
@property (nonatomic,strong)UIImageView * shortLine;//短线
@property (nonatomic,strong)UIImageView * longLine;//长下划线
@property (nonatomic,strong)YYLabel * nameLabel;//名字
@property (nonatomic,strong)YYLabel * successLabel;//成功借款
@property (nonatomic,strong)YYLabel * tagLabel;//底部标签说明
@property (nonatomic,strong)YYLabel * numPeople;//成功人数
-(void)setData:(LoanMainCellModel*)model;

@end
