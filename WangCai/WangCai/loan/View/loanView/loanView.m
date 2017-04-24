//
//  loanView.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "loanView.h"
#import "PickFrameView.h"


#define LOANLABEL_TOP 30*K_S_W //文字距离顶部
#define LOANLABEL_LEFT 20*K_S_W  //文字距离左边距
#define LOANLABEL_FONT 14 //字体大小
#define LOANLABEL_COLOR @"666666"
#define ONE_BUT_LABEL_TOP 30*K_S_W //第一个按钮距离文字丁距离
#define BUTTON_W 162*K_S_W
#define BUTTON_H 38*K_S_W
#define BUTTON_RIGHT 20*K_S_W
#define BUTTON_COLOR @"FF9933"
#define BUT_BUT_W 15*K_S_W//左右按钮间距
#define BUT_BUT_H 15*K_S_W //上下按钮间距
#define CHANG_H 30 
#define CHANGE_BUT_W 2
@implementation loanView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        if(!_changePick){
            _changePick = [[PickFrameView alloc]init];
            _changePick.tagImage = [UIImage imageNamed:@"money"];
            _changePick.pickArray = @[@"不限",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"15000",@"20000",@"25000",@"30000",@"40000",@"50000",@"100000",@"200000",@"500000"];
            __weak typeof(self) weakSelf = self;
            _changePick.pickBlock = ^(NSString*str){
                [weakSelf blockClick:str];
            };
            _changePick.selectStr = _changePick.pickArray[0];
            [self addSubview:_changePick];
        }
        if(!_loanLabel){
            _loanLabel = [[YYLabel alloc]init];
            _loanLabel.text = @"借款金额(元)：";
            _loanLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LOANLABEL_FONT];
            _loanLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_loanLabel];
        }
        if(!_twoButton){
            _twoButton = [[loanButtonView alloc]init];
            _twoButton.delegate = self;
            _twoButton.backgroundColor = [RGBColor colorWithHexString:BUTTON_COLOR];
            _twoButton.rightLabel.text = @"5000";
            _twoButton.leftLabel.text = @"5个月";
           // [_twoButton addTarget:self action:@selector(butOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_twoButton];
            
        }
        if(!_threeButton){
            _threeButton = [[loanButtonView alloc]init];
            _threeButton.delegate = self;
            _threeButton.backgroundColor = [RGBColor colorWithHexString:BUTTON_COLOR];
            _threeButton.rightLabel.text = @"8000";
            _threeButton.leftLabel.text = @"3个月";
             //[_twoButton addTarget:self action:@selector(butOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_threeButton];
        }
        if(!_oneButton){
            _oneButton = [[loanButtonView alloc]init];
            _oneButton.delegate = self;
            _oneButton.backgroundColor = [RGBColor colorWithHexString:BUTTON_COLOR];
             //[_twoButton addTarget:self action:@selector(butOnClick:) forControlEvents:UIControlEventTouchUpInside];
            _oneButton.rightLabel.text = @"3000";
            _oneButton.leftLabel.text = @"3个月";
            [self addSubview:_oneButton];
        }
        if(!_fourButton){
            _fourButton = [[loanButtonView alloc]init];
            _fourButton.delegate = self;
            _fourButton.backgroundColor = [RGBColor colorWithHexString:BUTTON_COLOR];
            _fourButton.rightLabel.text = @"20000";
            _fourButton.leftLabel.text = @"12个月";
            // [_twoButton addTarget:self action:@selector(butOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_fourButton];
        }
    }
    return self;
}
-(void)tapClick:(UIView *)view
{
    NSInteger tag = 0;
    if(view == _oneButton){
        tag  = 20;
    }else if(view == _twoButton){
        tag = 21;
    }else if (view == _threeButton){
        tag = 22;
    }else if (view == _fourButton){
        tag = 23;
    }
    if(self.butBlock){
        self.butBlock([NSString stringWithFormat:@"%ld",(long)tag]);
    }
}
//pickView选择
-(void)blockClick:(NSString *)str{
    if(self.butBlock){
        if([str isEqualToString:@"不限"]){
            str = @"0";
        }
        self.butBlock(str);
    }
}
-(void)butOnClick:(UIButton*)but{
    if(self.butBlock){
        self.butBlock([NSString stringWithFormat:@"%ld",(long)but.tag]);
    }
}
-(void)layoutSubviews
{
    
    [_loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(LOANLABEL_TOP);
        make.left.equalTo(self.mas_left).with.offset(LOANLABEL_LEFT);
        make.height.mas_equalTo(LOANLABEL_FONT);
    }];
    
    [_oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loanLabel.mas_bottom).with.offset(ONE_BUT_LABEL_TOP);
        make.left.equalTo(self.mas_left).with.offset(LOANLABEL_LEFT);
        make.width.mas_equalTo(BUTTON_W);
        make.height.mas_equalTo(BUTTON_H);
    }];
    [_twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneButton.mas_top).with.offset(0);
        make.left.equalTo(_oneButton.mas_right).with.offset(BUT_BUT_W);
        make.width.mas_equalTo(BUTTON_W);
        make.height.mas_equalTo(BUTTON_H);
    }];
    [_threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneButton.mas_bottom).with.offset(BUT_BUT_H);
        make.left.equalTo(_oneButton.mas_left).with.offset(0);
        make.width.mas_equalTo(BUTTON_W);
        make.height.mas_equalTo(BUTTON_H);
    }];
    [_fourButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_threeButton.mas_top).with.offset(0);
        make.left.equalTo(_threeButton.mas_right).with.offset(BUT_BUT_W);
        make.width.mas_equalTo(BUTTON_W);
        make.height.mas_equalTo(BUTTON_H);
    }];
    [_changePick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loanLabel.mas_right).with.offset(CHANGE_BUT_W);
        //make.bottom.equalTo(_loanLabel.mas_bottom).with.offset(10);
        make.right.equalTo(_twoButton.mas_right).with.offset(0);
        make.height.mas_equalTo(CHANG_H);
        make.centerY.equalTo(_loanLabel.mas_centerY).with.offset(0);
    }];
}

@end
