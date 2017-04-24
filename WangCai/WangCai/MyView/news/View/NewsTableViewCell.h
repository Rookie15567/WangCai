//
//  NewsTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
@property (nonatomic,strong) YYLabel * timeLabel;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIView * backView;
-(void)setData:(NewsModel*)model;
@end
