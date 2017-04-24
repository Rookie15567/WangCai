//
//  ScrollHeadViewCell.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "ScrollHeadViewCell.h"

@implementation ScrollHeadViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageView];
    //self.imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.imageView.frame = self.bounds;
}
@end
