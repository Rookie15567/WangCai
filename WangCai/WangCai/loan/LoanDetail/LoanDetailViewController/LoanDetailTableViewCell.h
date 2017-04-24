//
//  LoanDetailTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanDetailModel.h"
#define LABLE_FONT 12
#define BIG_LABLE_FONT 14
@interface LoanDetailTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * lineImageView;
@property (nonatomic,strong)YYLabel * oneLabel;//类型
@property (nonatomic,strong)YYLabel * twoLabel;//内容
-(void)changData:(NSArray*)array;
+(CGFloat)height;
@end
