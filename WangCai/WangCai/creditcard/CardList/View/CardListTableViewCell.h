//
//  CardListTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardListModel.h"
@interface CardListTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * tagImageView;
@property (nonatomic,strong)YYLabel * titleLabel;
@property (nonatomic,strong)YYLabel * detaillabel;
@property (nonatomic,strong) UIImageView * lineImageView;
-(void)changData:(CardListModel*)model;
@end
