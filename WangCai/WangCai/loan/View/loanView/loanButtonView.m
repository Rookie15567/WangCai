//
//  loanButtonView.m
//  WangCai
//
//  Created by cds on 16/12/12.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "loanButtonView.h"

@implementation loanButtonView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        self.layer.cornerRadius = 10;
        if(!_rightLabel){
            _rightLabel = [YYLabel new];
            _rightLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            _rightLabel.textColor = [UIColor whiteColor];
            _rightLabel.text = @"3000元";
            [self addSubview:_rightLabel];
        }
        
        if(!_leftLabel){
            _leftLabel = [YYLabel new];
            _leftLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
            _leftLabel.textColor = [UIColor whiteColor];// [RGBColor colorWithHexString:@"F9F9F9"];
            _leftLabel.text = @"月数";
            [self addSubview:_leftLabel];
        }
        if(_backView){
            _backView = [UIView new];
            [_backView addGestureRecognizer:tap];
          //  [self addSubview:_backView];
        }
    }
    return self;

}
-(void)layoutSubviews
{
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12*K_S_W);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-12*K_S_W);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
//    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
}
-(void)tapClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tapClick:)]){
        [self.delegate tapClick:self];
    }
}
-(void)changDataRightString:(NSString *)right leftString:(NSString*)left{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
