//
//  PickFrameView.m
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "PickFrameView.h"
#import "DQconstellationView.h"
@interface PickFrameView ()<DQconstellationViewDelegate>
@property (nonatomic, strong) DQconstellationView *DQconstellationView;
@end
#define TAG_TOP 6
#define TAG_W 12
#define TAG_LAB 5
#define LABEL_FONT 14
#define LINE_W 0.5
@implementation PickFrameView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [RGBColor colorWithHexString:TEXT_PLCCCCCOLOR];
        self.layer.cornerRadius = 2;
        if(!_DQconstellationView){
            self.DQconstellationView = [DQconstellationView new];
            self.DQconstellationView.delegate = self;
            
            //[self addSubview:_DQconstellationView];
        }
        if(!_backView){
            _backView = [[UIView alloc]init];
            _backView.backgroundColor = [UIColor whiteColor];
            _backView.userInteractionEnabled = YES;
            _backView.layer.cornerRadius = 2;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnClick)];
            [_backView addGestureRecognizer:tap];
            
            [self addSubview:_backView];
        }
        if(!_tagImageView){
            _tagImageView = [[UIImageView alloc]init];
            _tagImageView.userInteractionEnabled = YES;
            [_backView addSubview:_tagImageView];
        }
        if(!_conLabel){
            _conLabel = [[YYLabel alloc]init];
            _conLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _conLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [_backView addSubview:_conLabel];
        }
        if(!_tailImageView){
            
            _tailImageView = [[UIImageView alloc]init];
            _tailImageView.userInteractionEnabled = YES;
            [_backView addSubview:_tailImageView];
        }
    }
    return self;
}
-(void)setPickArray:(NSArray *)pickArray
{
    _pickArray = pickArray;
    if(_DQconstellationView){
        _DQconstellationView.SourceArray = _pickArray;
        
       
    }
}
-(void)setSelectStr:(NSString *)selectStr
{
    _selectStr = selectStr;
    _conLabel.text = selectStr;
}
-(void)tapOnClick{
    
    [self.DQconstellationView startAnimationFunction];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(LINE_W, LINE_W, LINE_W, LINE_W));
    }];
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.left.equalTo(self.mas_left).with.offset(TAG_TOP);
        make.width.mas_equalTo(TAG_W);
        make.height.mas_equalTo(TAG_W);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_tailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(TAG_TOP);
        make.right.equalTo(self.mas_right).with.offset(-TAG_TOP);
        make.width.mas_equalTo(TAG_W);
        make.height.mas_equalTo(TAG_W);
    }];
    [_conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(_tagImageView.mas_right).with.offset(TAG_LAB);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.right.equalTo(_tailImageView.mas_left).offset(0);
        //make.width.mas_equalTo(TAG_W);
        //make.height.mas_equalTo(TAG_W);
    }];
}
-(void)setSelectRow:(NSInteger)selectRow
{
    _selectRow = selectRow;
    _DQconstellationView.selectRow = selectRow;
}
-(void)setTagImage:(UIImage *)tagImage
{
    _tagImage = tagImage;
    _tagImageView.image = tagImage;
}
-(void)setTagImageView:(UIImageView *)tagImageView
{
    _tailImageView = tagImageView;
}
-(void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str
{
    if(self.pickBlock){
        self.pickBlock(str);
        _conLabel.text = str;
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
