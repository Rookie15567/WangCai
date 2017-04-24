//
//  MyInfoTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@implementation MyInfoTableViewCell
#define TITLE_FONT 14
#define IMG_TOP 14
#define IMG_LEFT 22
#define IMG_SIZE 22
#define LABEL_IMG_W 15
#define LABEL_TOP 18
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        if(!_imgView){
            _imgView = [UIImageView new];
            [self addSubview:_imgView];
        }
        if(!_titleLabel){
            _titleLabel = [YYLabel new];
            _titleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _titleLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            
            [self addSubview:_titleLabel];
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
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(10);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineImageView.mas_bottom).with.offset(IMG_TOP);
        make.left.equalTo(self.mas_left).with.offset(IMG_LEFT);
        make.width.mas_equalTo(IMG_SIZE);
        make.height.mas_equalTo(IMG_SIZE);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineImageView.mas_bottom).with.offset(LABEL_TOP);
        make.left.equalTo(_imgView.mas_right).with.offset(LABEL_IMG_W);
        make.height.mas_equalTo(TITLE_FONT);
    }];
    
}
-(void)setimgImage:(NSString*)imgStr titleString:(NSString*)str{
    _titleLabel.text = str;
    _imgView.image = [UIImage imageNamed:imgStr];
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
