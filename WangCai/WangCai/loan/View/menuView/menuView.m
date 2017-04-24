//
//  menuView.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "menuView.h"
#define LABEL_FONT 14
#define LABEL_TOP 6*K_S_H
#define BUTTON_TOP 16*K_S_H
#define BUTTON_SIZE 42*K_S_W
@implementation menuView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        if(!_oneButton){
            _oneButton = [[UIButton alloc]init];
            _oneButton.tag = 10;
           // [_oneButton setTitle:@"极速借款" forState:UIControlStateNormal];
            [_oneButton setImage:IMAGE_NAMED(@"loan_speed") forState:UIControlStateNormal];
            [_oneButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_oneButton];
        }
        if(!_oneLabel){
            _oneLabel = [YYLabel new];
            _oneLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _oneLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _oneLabel.text = @"极速贷款";
            [self addSubview:_oneLabel];
        }
        if(!_twoButton){
            _twoButton = [[UIButton alloc]init];
            _twoButton.tag = 11;
            
            //[_twoButton setTitle:@"大额借款" forState:UIControlStateNormal];
            [_twoButton setImage:IMAGE_NAMED(@"loan_big") forState:UIControlStateNormal];
            [_twoButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_twoButton];
        }
        if(!_twoLabel){
            _twoLabel = [YYLabel new];
            _twoLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _twoLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _twoLabel.text = @"大额借款";
            [self addSubview:_twoLabel];
        }
        if(!_threeButton){
            _threeButton = [[UIButton alloc]init];
            _threeButton.tag = 12;
            //[_threeButton setTitle:@"办卡信用" forState:UIControlStateNormal];
            [_threeButton setImage:IMAGE_NAMED(@"loan_card") forState:UIControlStateNormal];
            [_threeButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_threeButton];
        }
        if(!_threeLabel){
            _threeLabel = [YYLabel new];
            _threeLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _threeLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _threeLabel.text = @"信用卡";
            [self addSubview:_threeLabel];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0.1*S_W);
        make.top.equalTo(self.mas_top).with.offset(BUTTON_TOP);
        make.height.mas_equalTo(BUTTON_SIZE);
         make.width.mas_equalTo(BUTTON_SIZE);
    }];
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_oneButton.mas_centerX).with.offset(0);
        make.height.mas_equalTo(LABEL_FONT);
        make.top.equalTo(_oneButton.mas_bottom).with.offset(LABEL_TOP);
    }];
    [_twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.mas_top).with.offset(BUTTON_TOP);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(BUTTON_SIZE);
        make.width.mas_equalTo(BUTTON_SIZE);
    }];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_twoButton.mas_centerX).with.offset(0);
        make.height.mas_equalTo(LABEL_FONT);
        make.top.equalTo(_oneButton.mas_bottom).with.offset(LABEL_TOP);
    }];
    [_threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-0.1*S_W);
        make.top.equalTo(self.mas_top).with.offset(BUTTON_TOP);
        make.height.mas_equalTo(BUTTON_SIZE);
        make.width.mas_equalTo(BUTTON_SIZE);
    }];
    [_threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_threeButton.mas_centerX).with.offset(0);
        make.height.mas_equalTo(LABEL_FONT);
        make.top.equalTo(_oneButton.mas_bottom).with.offset(LABEL_TOP);
    }];
}
-(void)OnClick:(UIButton*)but{
    if(self.butOnClickBlock){
        self.butOnClickBlock([NSString stringWithFormat:@"%ld",but.tag]);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
