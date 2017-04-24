//
//  LoanTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanTableViewCell.h"
#import <UIImageView+YYWebImage.h>
#define CON_IMAGE_TOP  15*K_S_H //图片距离上部
#define CON_IMAGE_LEFT 20*K_S_W //左部
#define CON_IMAGE_SIZE 40*K_S_W
#define CON_IMAGE_BOTM 15
#define CON_IMAGE_TYPE 10*K_S_W //图片到类型距离
#define TYPE_LABEL_FONT 14 //字体大小
#define OTHER_LABEL_FONT 12

//#ifdef IPHONE5_OR_5S
//#define RIGHT_LEFT_SIZE 20 //左右间距
//#else
//#define RIGHT_LEFT_SIZE 40*K_S_W //左右间距
//#endif

@implementation LoanTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        if(!_contenImageView){
            _contenImageView = [[UIImageView alloc]init];
            _contenImageView.image = [UIImage imageNamed:@"pic_bg"];
            [self addSubview:_contenImageView];
        }
        if(!_typeLabel){
            _typeLabel = [[YYLabel alloc]init];
            _typeLabel.text = @"用钱宝-工薪贷";
            _typeLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TYPE_LABEL_FONT];
            _typeLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            [self addSubview:_typeLabel];
            
        }
        if(!_peopleLabel){
            _peopleLabel = [[YYLabel alloc]init];
            _peopleLabel.text = @"申请人数：";
            _peopleLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_LABEL_FONT];
            _peopleLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_peopleLabel];
        }
        if(!_numLabel){
            _numLabel = [[YYLabel alloc]init];
            _numLabel.text = @"234234人";
            _numLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_LABEL_FONT];//SYSTEM_FONT(13);
            _numLabel.textColor = [RGBColor colorWithHexString:TEXT_REDCOLOR];            [self addSubview:_numLabel];
        }
        if(!_rateLabel){
            _rateLabel = [[YYLabel alloc]init];
            _rateLabel.text = @"月利率：";
            _rateLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_LABEL_FONT];//SYSTEM_FONT(13);
            _rateLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_rateLabel];
        }
        if(!_rateNumLabel){
            _rateNumLabel = [[YYLabel alloc]init];
            _rateNumLabel.text = @"1%";
            _rateNumLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:OTHER_LABEL_FONT];//SYSTEM_FONT(13);
            _rateNumLabel.textColor = [RGBColor colorWithHexString:TEXT_REDCOLOR];
            [self addSubview:_rateNumLabel];
        }
        if(!_limitLabel){
            _limitLabel = [[YYLabel alloc]init];
            _limitLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TYPE_LABEL_FONT];//SYSTEM_FONT(15);
            _limitLabel.text = @"额度：1000-59999";
            _limitLabel.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            [self addSubview:_limitLabel];
        }
        if(!_lineImage){
            _lineImage = [[UIImageView alloc]init];
            _lineImage.backgroundColor = [RGBColor colorWithHexString:LINE_COLOR];
            [self addSubview:_lineImage];
        }
            
    }
    return self;
}
-(void)layoutSubviews{
    static float RIGHT_LEFT_SIZE;
    if(IPHONE4_OR_4S){
        RIGHT_LEFT_SIZE = 150;
    }else if (IPHONE5_OR_5S){
        RIGHT_LEFT_SIZE = 180;
    }else{
        RIGHT_LEFT_SIZE = 233*K_S_W;
    }
    [_contenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).with.offset(CON_IMAGE_TOP);
        make.left.equalTo(self.mas_left).with.offset(CON_IMAGE_LEFT);
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.width.mas_equalTo(CON_IMAGE_SIZE);
        make.height.mas_equalTo(CON_IMAGE_SIZE);
    }];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contenImageView.mas_top).with.offset(0);
        make.left.equalTo(_contenImageView.mas_right).with.offset(CON_IMAGE_TYPE);
        make.height.mas_equalTo(TYPE_LABEL_FONT);
    }];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(_contenImageView.mas_right).with.offset(CON_IMAGE_TYPE);
        make.bottom.equalTo(_contenImageView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(OTHER_LABEL_FONT);
    }];
    
    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.left.equalTo(_typeLabel.mas_right).with.offset(RIGHT_LEFT_SIZE);
        make.left.equalTo(self.mas_left).with.offset(RIGHT_LEFT_SIZE);
        make.bottom.equalTo(_peopleLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(OTHER_LABEL_FONT);
    }];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_peopleLabel.mas_right).with.offset(0);
        make.bottom.equalTo(_peopleLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(OTHER_LABEL_FONT);
        make.right.mas_equalTo(_rateLabel.mas_left).with.offset(0);
    }];
    [_rateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rateLabel.mas_right).with.offset(0);
        make.bottom.equalTo(_rateLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(OTHER_LABEL_FONT);
    }];
    [_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_typeLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(RIGHT_LEFT_SIZE);
        //make.left.equalTo(_typeLabel.mas_right).with.offset(RIGHT_LEFT_SIZE);
       // make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(TYPE_LABEL_FONT);
    }];
   [_lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self.mas_bottom).with.offset(0);
       make.height.mas_equalTo(1);
       make.width.mas_equalTo(S_W);
   }];
    
}
-(void)setDataSource:(LoanMainCellModel*)model{
    
    //_contenImageView.image = [UIImage imageNamed:@"pic_bg"];
    [_contenImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,model.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
    _typeLabel.text = model.name;
//    _numLabel.text =
    _numLabel.text = model.usernum;//@"234234人";
//    CGSize size = [_numLabel sizeThatFits:CGSizeMake(MAXFLOAT, 0)];
//    [_numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(size.width);
//    }];
    _limitLabel.text = [NSString stringWithFormat:@"额度：%@-%@",model.minRmb,model.maxRmb];//@"额度：1000-59999";
    
    CGFloat ratt = [model.rate floatValue];
    _rateNumLabel.text = [NSString stringWithFormat:@"%.2f%%",ratt];//model.rate;//@"1%";
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
