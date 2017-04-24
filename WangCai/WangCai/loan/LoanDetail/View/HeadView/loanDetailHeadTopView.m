//
//  loanDetailHeadTopView.m
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "loanDetailHeadTopView.h"
#define TAG_LEFT 20*K_S_W //图片距离左部
#define TAG_TOP 16*K_S_H //图片距离顶部
#define ALL_RIGHT 20*K_S_W //距离右边距离
#define TAGIMAGE_W 40 //图片大小
#define TAG_LAB 10 //图片距离文字
#define NAMELAB_FONT 18 //大文字字体
#define OTHERLAB_FONT 11 //另外字体大小
#define LINE_BOTTOM_H 40*K_S_H
@implementation loanDetailHeadTopView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
        if(!_tagImageView){
            _tagImageView = [[UIImageView alloc]init];
            [self addSubview:_tagImageView];
        }
        if(!_nameLabel){
            _nameLabel = [YYLabel new];
            _nameLabel.textColor = [UIColor whiteColor];
            _nameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:NAMELAB_FONT];
            [self addSubview:_nameLabel];
        }
        if(!_peopleNum){
            _peopleNum = [YYLabel new];
            _peopleNum.textColor = [UIColor whiteColor];
            _peopleNum.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHERLAB_FONT];
            [self addSubview:_peopleNum];
        }
        if(!_success){
            _success = [YYLabel new];
            _success.textColor = [UIColor whiteColor];
            _success.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHERLAB_FONT];
            [self addSubview:_success];
        }
        if(!_adLabel){
            _adLabel = [YYLabel new];
            _adLabel.textColor = [UIColor whiteColor];
            _adLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
            [self addSubview:_adLabel];
        }
        if(!_lineImageView){
            _lineImageView = [UIImageView new];
            _lineImageView.backgroundColor = [RGBColor colorWithHexString:@"5dc9ef"];
            
            [self addSubview:_lineImageView];
        }
    }
    return self;
}
-(void)layoutSubviews{
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.left.equalTo(self.mas_left).with.offset(TAG_LEFT);
        make.width.mas_equalTo(TAGIMAGE_W);
        make.height.mas_equalTo(TAGIMAGE_W);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagImageView.mas_top).with.offset(0);
        make.left.equalTo(_tagImageView.mas_right).with.offset(TAG_LAB);
        make.height.mas_equalTo(NAMELAB_FONT);
    }];
    [_peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-ALL_RIGHT);
        make.height.mas_equalTo(OTHERLAB_FONT);
        make.centerY.mas_equalTo(_nameLabel.mas_centerY);
    }];
    [_success mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(OTHERLAB_FONT);
        make.left.equalTo(_nameLabel.mas_left).with.offset(0);
        make.bottom.equalTo(_tagImageView.mas_bottom).with.offset(0);
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(TAG_LEFT);
        make.bottom.equalTo(self.mas_bottom).with.offset(-LINE_BOTTOM_H);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.mas_right).with.offset(-ALL_RIGHT);
    }];
    [_adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(TAG_LEFT);
        make.right.equalTo(self.mas_right).with.offset(-ALL_RIGHT);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.top.equalTo(_lineImageView.mas_bottom).with.offset(0);
    }];
}
-(void)setData:(LoanDetailModel*)model{
    _tagImageView.image = [UIImage imageNamed:@"text"];
    [_tagImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,model.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
    
    _nameLabel.text = model.name;
    _peopleNum.text = [NSString stringWithFormat:@"%@人已放款",model.usernum];
    
    _adLabel.text = model.info;
    if(model.topflag == nil || [model.topflag isEqualToString:@"0"]){
        _success.text = [NSString stringWithFormat:@"99.9%%成功率"]; //@"99.9%";
    }else{
      _success.text = [NSString stringWithFormat:@"%@%%成功率",model.topflag]; //@"99.9%";
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
