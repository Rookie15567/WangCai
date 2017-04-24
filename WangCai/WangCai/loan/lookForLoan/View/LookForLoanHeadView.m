//
//  LookForLoanHeadView.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LookForLoanHeadView.h"
#define ONELABEL_TOP 20*K_S_H
#define ONELABEL_LEFT 20*K_S_W
#define LABELWIDTH 30
#define LAB_LAB 15*K_S_H
#define LAB_LEFT 10*K_S_W
#define LAB_RIGHT 20
#define PICK_RIGHT 20
#define LAB_FONT 14
@implementation LookForLoanHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        if(!_oneLabel){
            _oneLabel = [[YYLabel alloc]init];
            _oneLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LAB_FONT];
            _oneLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _oneLabel.text = @"借款金额(元)：";
            [self addSubview:_oneLabel];
        }
        if(!_twoLabel){
            _twoLabel = [[YYLabel alloc]init];
            _twoLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LAB_FONT];
            _twoLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _twoLabel.text = @"分期期限(月)：";
            [self addSubview:_twoLabel];
        }
        if(!_onePick){
            _onePick = [[PickFrameView alloc]init];
            _onePick.tagImage = [UIImage imageNamed:@"money"];
            
            _onePick.pickArray = @[@"不限",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"15000",@"20000",@"25000",@"30000",@"40000",@"50000",@"100000",@"200000",@"500000"];
            __weak typeof(self) weakSelf = self;
            _onePick.pickBlock = ^(NSString*str){
                [weakSelf pickClickType:pickOne clickString:str];
            };
            [self addSubview:_onePick];
        }
        if(!_twoPick){
            _twoPick = [[PickFrameView alloc]init];
            _twoPick.tagImage = [UIImage imageNamed:@"time_limit"];
            _twoPick.pickArray = @[@"不限",@"1",@"2",@"3",@"5",@"6",@"12",@"18",@"24",@"36",@"48"];
            __weak typeof(self) weakSelf = self;
            _twoPick.pickBlock = ^(NSString*str){
                [weakSelf pickClickType:pickTwo clickString:str];
            };
            [self addSubview:_twoPick];
        }
    }
    return self;
}
-(void)setSelectmnum:(NSString *)selectmnum
{
    _selectmnum = selectmnum;
    if([selectmnum isEqualToString:@"0"])
    {
        _twoPick.selectStr = _twoPick.pickArray[0];
    }
    else
    {
    for(int i=0;i<[_twoPick.pickArray count];i++){
        if([selectmnum isEqualToString:_twoPick.pickArray[i]]){
            _twoPick.selectRow = i;
            if([selectmnum isEqualToString:@"0"] || selectmnum == nil){
                 _twoPick.selectStr = @"不限";//_twoPick.pickArray[0];
            }else{
               _twoPick.selectStr = selectmnum;
            }
           
            
            break;
        }
    }
    }
}
-(void)setSelectRmbNum:(NSString *)selectRmbNum
{
    _selectRmbNum = selectRmbNum;
    if([selectRmbNum isEqualToString:@"0"])
    {
        _onePick.selectStr = _onePick.pickArray[0];
    }else{
    for(int i=0;i<[_onePick.pickArray count];i++){
        if([selectRmbNum isEqualToString:_onePick.pickArray[i]]){
            _onePick.selectRow = i;
            if(selectRmbNum.length <1){
                _onePick.selectStr = _onePick.pickArray[0];
            }else{
                _onePick.selectStr = selectRmbNum;
            }
            
            break;
        }
    }
    }
}
-(void)layoutSubviews
{
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(ONELABEL_TOP);
        make.left.equalTo(self.mas_left).with.offset(ONELABEL_LEFT);
        make.height.mas_equalTo(LABELWIDTH);
    }];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneLabel.mas_bottom).with.offset(LAB_LAB);
        make.left.equalTo(self.mas_left).with.offset(ONELABEL_LEFT);
        make.height.mas_equalTo(LABELWIDTH);
    }];
    [_onePick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oneLabel.mas_top).with.offset(0);
        make.left.equalTo(_oneLabel.mas_right).with.offset(0);
        make.height.mas_equalTo(LABELWIDTH);
        make.right.equalTo(self.mas_right).with.offset(-PICK_RIGHT);
    }];
    [_twoPick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoLabel.mas_top).with.offset(0);
        make.left.equalTo(_twoLabel.mas_right).with.offset(0);
        make.height.mas_equalTo(LABELWIDTH);
        make.right.equalTo(self.mas_right).with.offset(-PICK_RIGHT);
    }];
}
-(void)pickClickType:(pickType)type clickString:(NSString*)str{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(pickClickAndType:ClickString:)]){
        [self.delegate pickClickAndType:type ClickString:str];
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
