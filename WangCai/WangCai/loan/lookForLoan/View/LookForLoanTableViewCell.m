//
//  LookForLoanTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LookForLoanTableViewCell.h"
#define IMAGE_TOP_H 20//图片距离上
#define IMAGE_TOP_R 20 //图片距离右
#define IMAGE_SZIE 40//图片大小
#define TAG_W 28//标签宽
#define TAG_H 16 //标签高
#define SHORT_BOM 40  //短线到底部
#define LONG_LINE_H 10 //长线高度
#define NAME_FONT 15 //字号
#define OTHER_FONT 13
#define TAG_FONT 14
@implementation LookForLoanTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        if(!_contenImageView){
            _contenImageView = [[UIImageView alloc]init];
            [self addSubview:_contenImageView];
        }
        if(!_tagImageView){
            _tagImageView = [[UIImageView alloc]init];
            [self addSubview:_tagImageView];
        }
        if(!_shortLine){
            _shortLine = [[UIImageView alloc]init];
            _shortLine.backgroundColor = [RGBColor colorWithHexString:@"E9E9E9"];
            
            [self addSubview:_shortLine];
        }
        if(!_longLine){
            _longLine = [[UIImageView alloc]init];
            _longLine.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
            [self addSubview:_longLine];
        }
        if(!_tagLabel){
            _tagLabel = [[YYLabel alloc]init];
            _tagLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TAG_FONT];
            _tagLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            //_tagLabel.font = SYSTEM_FONT(TAG_FONT);
            [self addSubview:_tagLabel];
        }
        if(!_nameLabel){
            _nameLabel = [[YYLabel alloc]init];
            _nameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:NAME_FONT];
            _nameLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_nameLabel];
        }
        if(!_numPeople){
            _numPeople = [[YYLabel alloc]init];
            _numPeople.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_FONT];
            _numPeople.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_numPeople];
        }
        if(!_successLabel){
            _successLabel = [[YYLabel alloc]init];
            _successLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_FONT];
            _successLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_successLabel];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_contenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(IMAGE_TOP_H);
        make.left.equalTo(self.mas_left).with.offset(IMAGE_TOP_R);
        make.width.mas_equalTo(IMAGE_SZIE);
        make.height.mas_equalTo(IMAGE_SZIE);
    }];
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TAG_W);
        make.height.mas_equalTo(TAG_H);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
    }];
    [_shortLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-SHORT_BOM);
        make.left.equalTo(self.mas_left).with.offset(IMAGE_TOP_R);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(S_W - 2*IMAGE_TOP_R);
    }];
    [_longLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(LONG_LINE_H);
        make.left.equalTo(self.mas_left).with.offset(0);
    }];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(LONG_LINE_H);
        make.left.equalTo(self.mas_left).with.offset(IMAGE_TOP_R);
        make.top.equalTo(_shortLine.mas_bottom).with.offset(0);
        //make.height.mas_equalTo(TAG_FONT);
        make.bottom.equalTo(_longLine.mas_top).with.offset(0);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(IMAGE_TOP_H);
        make.left.equalTo(_contenImageView.mas_right).with.offset(5);
        make.height.mas_equalTo(NAME_FONT);
        
    }];
    [_numPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nameLabel.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-IMAGE_TOP_R);
        make.height.mas_equalTo(OTHER_FONT);
        
    }];
    [_successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contenImageView.mas_right).with.offset(5);
        make.bottom.equalTo(_contenImageView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(OTHER_FONT);
    }];
}
-(void)setData:(LoanMainCellModel *)model{
    _contenImageView.image = [UIImage imageNamed:@"text"];
    [_contenImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,model.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
    
    _tagLabel.text = @"随意借收到房间爱，师傅了啥地方开始";
    _nameLabel.text = @"你我到";
    _successLabel.text = @"成功率：99.99%";
    _tagImageView.image = [UIImage imageNamed:@"recommend"];
    _numPeople.text = @"29130已放款";
    _tagLabel.text = model.info;
    _nameLabel.text = model.name;
    _numPeople.text = model.usernum;
    if([model.flag isEqualToString:@"1"]){
        _tagImageView.hidden = NO;
        //_tagImageView.image = [UIImage imageNamed:@"recommend"];
    }else{
       _tagImageView.hidden = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
