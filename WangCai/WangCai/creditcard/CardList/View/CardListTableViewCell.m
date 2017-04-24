//
//  CardListTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "CardListTableViewCell.h"
#define TAG_LEFT 20
#define TAG_TOP 20
#define TAG_SIZE_W 60
#define TAG_SIZE_H 37
#define TITLE_FONT 14
#define DETAIL_FONT 12
#define TAG_LABEL_W 10
#define LABEL_LABEL_H 10
@implementation CardListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        if(!_tagImageView){
            _tagImageView = [UIImageView new];
            [self addSubview:_tagImageView];
        }
        if(!_titleLabel){
            _titleLabel = [YYLabel new];
            _titleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _titleLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            
            [self addSubview:_titleLabel];
        }
        if(!_detaillabel){
            _detaillabel = [YYLabel new];
            _detaillabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:DETAIL_FONT];
            _detaillabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            
            [self addSubview:_detaillabel];
        }
        if(!_lineImageView){
            _lineImageView = [UIImageView new];
            _lineImageView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
            [self addSubview:_lineImageView];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.left.equalTo(self.mas_left).with.offset(TAG_LEFT);
        make.width.mas_equalTo(TAG_SIZE_W);
        make.height.mas_equalTo(TAG_SIZE_H);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.left.equalTo(_tagImageView.mas_right).with.offset(TAG_LABEL_W);
        make.height.mas_equalTo(TITLE_FONT);
    }];
    [_detaillabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(LABEL_LABEL_H);
        make.left.equalTo(_tagImageView.mas_right).with.offset(TAG_LABEL_W);
        make.height.mas_equalTo(DETAIL_FONT);
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).with.offset(-1);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(1);
        
    }];
}
-(void)changData:(CardListModel *)model{
    _tagImageView.image = [UIImage imageNamed:@"last_2"];
    [_tagImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,model.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
    

    _titleLabel.text = model.name;
    _detaillabel.text = model.info;
  
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
