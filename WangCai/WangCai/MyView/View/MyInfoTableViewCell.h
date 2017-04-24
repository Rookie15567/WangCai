//
//  MyInfoTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * imgView;
@property (nonatomic,strong)YYLabel * titleLabel;
@property (nonatomic,strong)UIImageView * lineImageView;
-(void)setimgImage:(NSString*)imgStr titleString:(NSString*)str;
@end
