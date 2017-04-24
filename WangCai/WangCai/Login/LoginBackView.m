//
//  LoginBackView.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoginBackView.h"

@interface LoginBackView ()<UITextFieldDelegate>

@end
#define TEXTFILE_FONT 16
@implementation LoginBackView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        //self.backgroundColor = [UIColor whiteColor];
        if(!_logoImage){
        _logoImage = [[UIImageView alloc]init];
        _logoImage.image = [UIImage imageNamed:@"logo1"];
        [self addSubview:_logoImage];
        }
        if(!_enterLine){
        _enterLine = [UIImageView new];
        _enterLine.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
        [self addSubview:_enterLine];
        }
         if(!_enterImageView){
        _enterImageView = [UIImageView new];
        _enterImageView.image = [UIImage imageNamed:@"enter_user"];
        [self addSubview:_enterImageView];
         }
         if(!_enterTextFile){
        _enterTextFile = [UITextField new];
             _enterTextFile.delegate = self;
             _enterTextFile.placeholder = @"手机号";
             _enterTextFile.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TEXTFILE_FONT];
             _enterTextFile.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_enterTextFile];
         }
         if(!_secretLine){
        _secretLine = [UIImageView new];
        _secretLine.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
        [self addSubview:_secretLine];
         }
        if(!_secretImageView){
        _secretImageView = [UIImageView new];
        _secretImageView.image = [UIImage imageNamed:@"enter_secret"];
        [self addSubview:_secretImageView];
        }
        if(!_secretTextFile){
            _secretTextFile = [UITextField new];
            _secretTextFile.delegate = self;
            _secretTextFile.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TEXTFILE_FONT];
            _secretTextFile.placeholder = @"验证码";
            _secretTextFile.keyboardType = UIKeyboardTypeNumberPad;
            [self addSubview:_secretTextFile];
        }
        if(!_testButton){
        _testButton = [YYLabel new];
        _testButton.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:14];
        _testButton.textColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testClick)];
            [_testButton addGestureRecognizer:tap];
            _testButton.userInteractionEnabled = YES;
        _testButton.text = @"获取验证码";
        [self addSubview:_testButton];
        }
        if(!_sureView){
        _sureView = [UIView new];
            _sureView.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
        [self addSubview:_sureView];
        }
        if(!_sureLabel){
            _sureLabel = [YYLabel new];
            _sureLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            _sureLabel.userInteractionEnabled = YES;
            _sureLabel.textColor = [UIColor whiteColor];
            _sureLabel.text = @"登录";
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginClick)];
            //添加登录点击事件
            [_sureView addGestureRecognizer:tap];
            [_sureView addSubview:_sureLabel];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(112);
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(84);
    }];
    [_enterLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(_logoImage.mas_bottom).with.offset(107);
        make.left.equalTo(self.mas_left).with.offset(48);
        make.right.equalTo(self.mas_right).with.offset(-48);
    }];
    [_enterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_enterLine.mas_left).with.offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        make.bottom.equalTo(_enterLine.mas_top).with.offset(-8);
        
    }];
    [_enterTextFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_enterImageView.mas_right).with.offset(5);
        make.centerY.equalTo(_enterImageView.mas_centerY).with.offset(0);
        make.right.equalTo(_enterLine.mas_right).with.offset(0);
        make.height.mas_equalTo(18);
        
    }];
    
    [_secretLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(_enterLine.mas_bottom).with.offset(55);
        make.left.equalTo(self.mas_left).with.offset(48);
        make.right.equalTo(self.mas_right).with.offset(-48);
    }];
    [_secretImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_enterLine.mas_left).with.offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        make.bottom.equalTo(_secretLine.mas_top).with.offset(-8);
    }];
    [_testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secretLine.mas_right).with.offset(0);
        make.centerY.equalTo(_secretImageView.mas_centerY).with.offset(0);
        make.height.mas_equalTo(14);
    }];
    [_secretTextFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_secretImageView.mas_right).with.offset(5);
        make.centerY.equalTo(_secretImageView.mas_centerY).with.offset(0);
        make.right.equalTo(_testButton.mas_left).with.offset(0);
        make.height.mas_equalTo(18);
    }];
    
    [_sureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_secretLine.mas_left).with.offset(0);
        make.right.equalTo(_secretLine.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
        make.top.equalTo(_secretLine.mas_bottom).with.offset(50);
    }];
    [_sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.center.mas_equalTo(_sureView);
    }];

}
-(void)testClick{
    //点击获取验证码
    self.tetBlock(1);
}
-(void)loginClick{
    //点击登录
    self.tetBlock(2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
