//
//  ToolBarView.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "ToolBarView.h"
#define label_FONT 18
@implementation ToolBarView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
        
        if(!_back){
            _back = [UIView new];
            _back.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolBarClick)];
            [self addGestureRecognizer:tap];
            [self addSubview:_back];
        }
        if(!_label){
            _label = [YYLabel new];
            _label.userInteractionEnabled = YES;
            _label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            _label.textColor = [UIColor whiteColor];
            _label.text = @"立即借款";
            [_back addSubview:_label];
        }
        if(!_tagImageView){
            _tagImageView = [UIImageView new];
            _tagImageView.userInteractionEnabled = YES;
            _tagImageView.backgroundColor = [UIColor whiteColor];
            _tagImageView.image = [UIImage imageNamed:@"money_2"];
            [_back addSubview:_tagImageView];
        }
        
    }
    return self;
}
-(void)toolBarClick{
    if(self.ToolBlock){
        self.ToolBlock(1);
    }
}
-(void)layoutSubviews
{
    
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(26);
        make.top.equalTo(_back.mas_top).with.offset(0);
        make.left.equalTo(_back.mas_left).with.offset(0);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(label_FONT);
        make.centerY.equalTo(_tagImageView.mas_centerY).with.offset(0);
        make.left.equalTo(_tagImageView.mas_right).with.offset(9);
    }];
    CGSize size = [_label sizeThatFits:CGSizeMake(MAXFLOAT, 1)];
    
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(size.width+9+26);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
