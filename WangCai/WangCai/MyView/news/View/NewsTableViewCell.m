//
//  NewsTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "NewsTableViewCell.h"
#define TITLE_TOP 20
#define TITLE_LEFT 15
#define TITLE_RIHGT 15
#define TITLE_FONT 16
#define TIME_FONT 12
#define TIME_TOP 18

@implementation NewsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
        if(!_backView){
            _backView = [UIView new];
            _backView.backgroundColor = [UIColor whiteColor];
            [self addSubview:_backView];
        }
        if(!_titleLabel){
            _titleLabel = [UILabel new];
            _titleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _titleLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            _titleLabel.lineBreakMode = UILineBreakModeWordWrap;
            _titleLabel.numberOfLines = 0;
            
            [_backView addSubview:_titleLabel];
        }
        if(!_timeLabel){
            _timeLabel = [YYLabel new];
            _timeLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TIME_FONT];
            _timeLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [_backView addSubview:_timeLabel];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).with.offset(TITLE_TOP);
        make.left.equalTo(_backView.mas_left).with.offset(TITLE_LEFT);
        make.right.equalTo(_backView.mas_right).with.offset(-TITLE_LEFT);
        //make.height.mas_equalTo(2*TITLE_FONT);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(TIME_TOP);
        make.left.equalTo(_titleLabel.mas_left).with.offset(0);
        make.height.mas_equalTo(TIME_FONT);
    }];
}
-(void)setData:(NewsModel*)model{
    
    _titleLabel.text = model.title;
    _timeLabel.text = @"2016-12-12";
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
