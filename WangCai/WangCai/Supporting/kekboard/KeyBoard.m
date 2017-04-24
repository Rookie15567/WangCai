//
//  KeyBoard.m
//  WangCai
//
//  Created by cds on 16/12/8.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "KeyBoard.h"

@implementation KeyBoard

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
        if(!_sureButton){
            _sureButton = [UIButton new];
            _sureButton.tag = 33;
            [_sureButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
            [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
            [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:_sureButton];
        }
        if(!_contentLabel){
            _contentLabel = [YYLabel new];
            _contentLabel.textAlignment = NSTextAlignmentCenter;
            _contentLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:15];
            _contentLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            
            [self addSubview:_contentLabel];
        }
        if(!_leftButton){
            _leftButton = [UIButton new];
            [_leftButton setTitle:@"left" forState:UIControlStateNormal];
            [_leftButton setTintColor:[UIColor blackColor]];
            _leftButton.tag = 34;
            
            [_leftButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_leftButton];
        }
        if(!_rightButton){
            _rightButton = [UIButton new];
            [_rightButton setTitle:@"righ" forState:UIControlStateNormal];
            [_rightButton setTintColor:[UIColor blackColor]];
            _rightButton.tag = 35;
            [_rightButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_rightButton];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-30);
         make.width.mas_equalTo(44);
    }];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(44);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(_leftButton.mas_right).with.offset(0);
//        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.mas_equalTo(_leftButton);
        make.width.mas_equalTo(44);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(_rightButton.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.right.equalTo(_sureButton.mas_left).with.offset(0);
    }];
}
-(void)sureClick:(UIButton*)but{
    if(but.tag == 33){
        //确定
        if(self.delegate && [self.delegate respondsToSelector:@selector(sureClick:)]){
            [self.delegate sureClick:keySureClickType];
        }
    }else if (but.tag == 34){
        //左
        if(self.delegate && [self.delegate respondsToSelector:@selector(sureClick:)]){
            [self.delegate sureClick:keyLeftClickType];
        }
    }else if (but.tag == 35){
        //右
        if(self.delegate && [self.delegate respondsToSelector:@selector(sureClick:)]){
            [self.delegate sureClick:keyRightClickType];
        }
    }
    
}
-(void)setContentString:(NSString *)contentString
{
    _contentString = contentString;
    _contentLabel.text = contentString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
