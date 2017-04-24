//
//  cardTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "cardTableViewCell.h"
#define TAG_LEFT 22
#define TAG_TOP 17
#define TAG_SIZE 38
#define TITLE_TAG_W 10
#define DETAIL_TAG_W 9
#define DETAIL_TITLE_H 9
#define TITLE_FONT 14
#define DETAIL_FONT 12
@implementation cardTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        if(!_tagImageView){
            _tagImageView = [[UIImageView alloc]init];
            [self addSubview:_tagImageView];
        }
        if(!_titleLabel){
            _titleLabel = [YYLabel new];
            _titleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _titleLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            [self addSubview:_titleLabel];
        }
        if(!_detailLabel){
            _detailLabel = [YYLabel new];
            _detailLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:DETAIL_FONT];
            _detailLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_detailLabel];
        }
        if(!_lineImageView){
            _lineImageView = [UIImageView new];
            _lineImageView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
            [self addSubview:_lineImageView];
        }
    }
    return  self;
}
-(void)layoutSubviews
{
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.height.mas_equalTo(TAG_SIZE);
        make.width.mas_equalTo(TAG_SIZE);
        make.left.equalTo(self.mas_left).with.offset(TAG_LEFT);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.height.mas_equalTo(TITLE_FONT);
        make.left.equalTo(_tagImageView.mas_right).with.offset(TITLE_TAG_W);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(DETAIL_TITLE_H);
        make.height.mas_equalTo(DETAIL_FONT);
        make.left.equalTo(_tagImageView.mas_right).with.offset(DETAIL_TAG_W);
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.mas_bottom).with.offset(-1);
    }];
}
-(void)changData:(CredCardModel *)model{
    //_tagImageView.image = [UIImage imageNamed:@"text"];
    [_tagImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,model.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
    
    //_titleLabel.text = @"银行";
    _titleLabel.text = model.name;
    _detailLabel.text = model.info;
    //_detailLabel.text = @"5分钟极速批卡";
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
