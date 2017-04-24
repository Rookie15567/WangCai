//
//  LoanDetailTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanDetailTableViewCell.h"

static float heigh;
@implementation LoanDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        if(!_lineImageView){
            _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_W, 10)];
            _lineImageView.backgroundColor  = [RGBColor colorWithHexString:LINE_COLOR];
           
            [self addSubview:_lineImageView];
        }
        if(!_oneLabel){
            _oneLabel = [[YYLabel alloc]init];
            _oneLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABLE_FONT];
            _oneLabel.numberOfLines = 0;
            _oneLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_oneLabel];
        }
        if(!_twoLabel){
            _twoLabel = [[YYLabel alloc]init];
            _twoLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:BIG_LABLE_FONT];
            _twoLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _twoLabel.numberOfLines = 0;
            _twoLabel.lineBreakMode = UILineBreakModeWordWrap;
            [self addSubview:_twoLabel];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineImageView.mas_bottom).with.offset(10*K_S_H);
        make.left.equalTo(self.mas_left).with.offset(20*K_S_W);
        make.height.mas_equalTo(LABLE_FONT);
    }];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneLabel.mas_bottom).with.offset(10*K_S_H);
        make.left.equalTo(self.mas_left).with.offset(20*K_S_W);
        make.right.equalTo(self.mas_right).with.offset(-20*K_S_W);
//        make.height.mas_offset(BIG_LABLE_FONT);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10*K_S_W);
    }];
    
}
-(void)changData:(NSArray*)array{
    _oneLabel.text = array[0];
    
    _twoLabel.text = array[1];
//    CGSize size =[_twoLabel sizeThatFits:CGSizeMake(_twoLabel.frame.size.width, MAXFLOAT)];
//    _twoLabel.frame = CGRectMake(_twoLabel.frame.origin.x, _twoLabel.frame.origin.y, _twoLabel.frame.size.width, size.height);
}

+(CGFloat)height{
    return heigh;
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
