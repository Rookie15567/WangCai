//
//  trendHeadView.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "trendHeadView.h"
#define TITLE_FONT 12
#define CARD_W 140
#define CARD_H 88
#define CARD_TOP 42
#define CARD_RIGHT 15
#define DETAIL_LABEL_FONT 14
#define LABEL_FONT 12
@implementation trendHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click)];
        if(!_cardImageView){
            _cardImageView = [[UIImageView alloc]init];
            _cardImageView.userInteractionEnabled = YES;
            [_cardImageView addGestureRecognizer:tap];
            [self addSubview:_cardImageView];
        }
        if(!_label){
            _label = [[YYLabel alloc]init];
            _label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _label.text = @"热门";
            _label.userInteractionEnabled = YES;
            _label.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_label];
        }
        if(!_titleLabel){
            _titleLabel = [YYLabel new];
            _titleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _titleLabel.userInteractionEnabled = YES;
            _titleLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            
            [self addSubview:_titleLabel];
        }
        if(!_detailLabel){
            _detailLabel = [YYLabel new];
            _detailLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:DETAIL_LABEL_FONT];
            _detailLabel.userInteractionEnabled = YES;
            _detailLabel.textAlignment = NSTextAlignmentCenter;
            _detailLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_detailLabel];
        }//
        if(!_backView){
            _backView = [[UIView alloc]init];
            [_backView addGestureRecognizer:tap];
            [self addSubview:_backView];
        }
    }
    return self;
}
-(void)layoutSubviews
{
   [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
   }];
    if(_isShow){
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(14);
            make.left.equalTo(self.mas_left).with.offset(20);
            make.height.mas_equalTo(TITLE_FONT);
        }];
        [_cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CARD_H);
            make.width.mas_equalTo(CARD_W);
            make.right.equalTo(self.mas_right).with.offset(-CARD_RIGHT);
            make.top.equalTo(self.mas_top).with.offset(42);
        }];
    }else{
        [_cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CARD_H);
            make.width.mas_equalTo(CARD_W);
            make.left.equalTo(self.mas_left).with.offset(CARD_RIGHT);
            make.top.equalTo(self.mas_top).with.offset(42);
        }];
    }
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardImageView.mas_bottom).with.offset(13);
        make.centerX.equalTo(_cardImageView.mas_centerX).with.offset(0);
        make.height.mas_equalTo(LABEL_FONT);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).with.offset(22);
        make.centerX.equalTo(_titleLabel.mas_centerX).with.offset(0);
        make.height.mas_equalTo(DETAIL_LABEL_FONT);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
    }];

}
-(void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
}
-(void)isShowTitle:(BOOL)isShow position:(CardPosition)position
{
    if(isShow){
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(14);
            make.left.equalTo(self.mas_left).with.offset(20);
            make.height.mas_equalTo(TITLE_FONT);
        }];
        [_cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CARD_H);
            make.width.mas_equalTo(CARD_W);
            make.right.equalTo(self.mas_right).with.offset(-CARD_RIGHT);
            make.top.equalTo(self.mas_top).with.offset(42);
        }];
    }else{
        [_cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CARD_H);
            make.width.mas_equalTo(CARD_W);
            make.left.equalTo(self.mas_left).with.offset(CARD_RIGHT);
            make.top.equalTo(self.mas_top).with.offset(42);
        }];
    }
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardImageView.mas_bottom).with.offset(13);
        make.centerX.equalTo(_cardImageView.mas_centerX).with.offset(0);
        make.height.mas_equalTo(LABEL_FONT);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).with.offset(22);
        make.centerX.equalTo(_titleLabel.mas_centerX).with.offset(0);
        make.height.mas_equalTo(DETAIL_LABEL_FONT);
    }];

}
-(void)Click{
    if(self.trendBlock){
        self.trendBlock(1);
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
