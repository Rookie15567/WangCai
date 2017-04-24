//
//  cardTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CredCardModel.h"
@interface cardTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * tagImageView;
@property (nonatomic,strong)YYLabel * titleLabel;
@property (nonatomic,strong)YYLabel * detailLabel;
@property (nonatomic,strong)UIImageView * lineImageView;
-(void)changData:(CredCardModel*)model;
@end
