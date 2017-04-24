//
//  loanDetailBottomHeadView.m
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "loanDetailBottomHeadView.h"
#define LABEL_FONT 12
#define BIG_LABEL_FONT 18
#define LABEL_TOP 33*K_S_H//距离顶部距离

#ifdef IPHONE5_OR_5S
#define LABEL_LEFT 10*K_S_W //距离左部距离
//#define ONE_TWOPICK 3
#else
#define LABEL_LEFT 15*K_S_W //距离左部距离
//#define ONE_TWOPICK 10*K_S_W
#endif


#define PICKVIEW_W 109*K_S_W
#define TWO_PICK_W 100*K_S_W
#define PICKVIEW_H 30*K_S_H //pick的高


#define NAMELABEL_LEFT  45*K_S_W//名字距离左部距离
#define NAMELABEL_RIGHT 42*K_S_W
@implementation loanDetailBottomHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        if(!_oneLabel){
            _oneLabel = [[YYLabel alloc]init];
            _oneLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _oneLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _oneLabel.text = @"借款金额：";
            [self addSubview:_oneLabel];
        }
        if(!_onePickView){
            _onePickView = [PickFrameView new];
            _onePickView.tagImage = [UIImage imageNamed:@"money"];
            
            _onePickView.pickArray = @[@"不限",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"15000",@"20000",@"25000",@"30000",@"40000",@"50000",@"100000",@"200000",@"500000"];
            __weak typeof(self) weakSelf = self;
            _onePickView.pickBlock = ^(NSString*str){
                [weakSelf pickClickType:pickOne clickString:str];
            };
            [self addSubview:_onePickView];
        }
        if(!_twoLabel){
            _twoLabel = [YYLabel new];
            _twoLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LABEL_FONT];
            _twoLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _twoLabel.text = @"分期期限：";
            [self addSubview:_twoLabel];
        }
        if(!_twoPickView){
            _twoPickView = [[PickFrameView alloc]init];
            _twoPickView.tagImage = [UIImage imageNamed:@"time_limit"];
            _twoPickView.pickArray = @[@"不限",@"1",@"2",@"3",@"6",@"12",@"18",@"24",@"36",@"48"];
            __weak typeof(self) weakSelf = self;
            _twoPickView.pickBlock = ^(NSString*str){
                [weakSelf pickClickType:pickTwo clickString:str];
            };
            [self addSubview:_twoPickView];
        }
        if(!_moneyLabel){
            _moneyLabel = [YYLabel new];
            _moneyLabel.textColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
            _moneyLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            [self addSubview:_moneyLabel];
        }
        if(!_moneyNameLabel){
            _moneyNameLabel = [[YYLabel alloc]init];
            _moneyNameLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _moneyNameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
            _moneyNameLabel.text = @"每月还款";
            [self addSubview:_moneyNameLabel];
        }
        if(!_rateLabel){
            _rateLabel = [YYLabel new];
            _rateLabel.textColor =[RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
            _rateLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            [self addSubview:_rateLabel];
        }
        if(!_rateNameLabel){
            _rateNameLabel = [[YYLabel alloc]init];
            _rateNameLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _rateNameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
            _rateNameLabel.text = @"参考月利率";
            [self addSubview:_rateNameLabel];
        }
        if(!_speedLabel){
            _speedLabel = [YYLabel new];
            _speedLabel.textColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
            _speedLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:18];
            [self addSubview:_speedLabel];
        }
        if(!_speedNameLabel){
            _speedNameLabel = [[YYLabel alloc]init];
            _speedNameLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _speedNameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
            _speedNameLabel.text = @"最快放款";
            [self addSubview:_speedNameLabel];
        }
    }
    return self;
    
}
-(void)layoutSubviews
{
    static float  ONE_TWOPICK;
    if(IPHONE4_OR_4S){
        ONE_TWOPICK =3;
    }else if (IPHONE5_OR_5S){
        ONE_TWOPICK =3;
    }else{
        ONE_TWOPICK =10;
    }
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LABEL_LEFT);
        make.top.equalTo(self.mas_top).with.offset(LABEL_TOP);
        make.height.mas_offset(LABEL_FONT);
    }];
    [_onePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oneLabel.mas_right).with.offset(3);
        make.centerY.mas_equalTo(_oneLabel);
        make.height.mas_equalTo(PICKVIEW_H);
        make.width.mas_equalTo(PICKVIEW_W);
    }];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_onePickView.mas_right).with.offset(ONE_TWOPICK);
        make.centerY.equalTo(_oneLabel.mas_centerY).with.offset(0);
        make.height.mas_offset(LABEL_FONT);
    }];
    [_twoPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_oneLabel);
        make.left.equalTo(_twoLabel.mas_right).with.offset(3);
        make.width.mas_equalTo(TWO_PICK_W);
        make.height.mas_equalTo(PICKVIEW_H);
    }];
   
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoPickView.mas_bottom).with.offset(35*K_S_H);
        make.centerX.mas_equalTo(_moneyNameLabel);
        make.height.mas_equalTo(BIG_LABEL_FONT);
    }];
    [_moneyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).with.offset(10*K_S_H);
        make.height.mas_equalTo(LABEL_FONT);
        make.left.equalTo(self.mas_left).with.offset(NAMELABEL_LEFT);
    }];
    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoPickView.mas_bottom).with.offset(35*K_S_H);
        make.height.mas_equalTo(BIG_LABEL_FONT);
        make.centerX.mas_equalTo(self);
    }];
    [_rateNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).with.offset(10*K_S_H);
        make.height.mas_equalTo(LABEL_FONT);
        make.centerX.mas_equalTo(self);
    }];
    [_speedNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).with.offset(10*K_S_H);
        make.height.mas_equalTo(LABEL_FONT);
        make.right.equalTo(self.mas_right).with.offset(-NAMELABEL_RIGHT);
    }];
    [_speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoPickView.mas_bottom).with.offset(35*K_S_H);
        make.height.mas_equalTo(BIG_LABEL_FONT);
        make.centerX.mas_equalTo(_speedNameLabel);
    }];
}
-(void)pickClickType:(pickType)type clickString:(NSString*)str{
    if(type == pickOne){
        _oneString = str;
    }else if (type == pickTwo){
        _twoString = str;
    }
    if(self.delegate&&[self.delegate respondsToSelector:@selector(pickLoanVCClickAndType:ClickString:)]){
        [self.delegate pickLoanVCClickAndType:type ClickString:str];
    }
     _moneyLabel.text = [self calculateMoneyAllMoney:_oneString month:_twoString rate:_rateLabel.text ];
}
-(void)changData:(LoanDetailModel*)model{
    CGFloat rateF = [model.rate floatValue];
    _rateLabel.text = [NSString stringWithFormat:@"%.2f%%",rateF];
    _speedLabel.text = model.outtime;
    
    NSInteger rmb = [model.minRmb integerValue];
    NSInteger maxrmb = [model.maxRmb integerValue];
    NSLog(@"%@",[self arrayBydatamax:model.maxRmb min:model.minRmb]);
    
    _onePickView.pickArray = @[@"不限",@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"15000",@"20000",@"25000",@"30000",@"40000",@"50000",@"100000",@"200000",@"500000"]; //计算
    _onePickView.selectStr = model.minRmb;
    _twoPickView.selectStr = model.minM;
    _oneString =model.minRmb;
    _twoString = model.minM;
    _moneyLabel.text = [self calculateMoneyAllMoney:model.minRmb month:model.minM rate:model.rate];
    
    _twoPickView.pickArray = @[@"不限",@"1",@"3",@"6",@"12",@"24",@"36"];
}
-(NSString*)calculateMoneyAllMoney:(NSString*)money month:(NSString*)monthstr rate:(NSString*)rate
{
    NSLog(@"%@%@%@",money,monthstr,rate);
    if(money && monthstr && rate){
        CGFloat abuff = [money integerValue]/[monthstr integerValue];
        CGFloat buff = abuff+ [money integerValue]* [rate floatValue]/100;
        
        return [NSString stringWithFormat:@"%.2f",buff];
    }else{
        return @"";
    }
    
    
}
-(NSArray*)arrayBydatamax:(NSString*)maxRmb min:(NSString*)minRmb{
    NSMutableArray * array = [NSMutableArray array];
    NSInteger mirmb = [minRmb integerValue];
    NSInteger maRmb = [maxRmb integerValue];
    NSArray * qianArr = @[@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000"];
    NSArray * wanArr = @[@"15000",@"20000",@"25000",@"30000",@"50000",@"100000"];
    if(mirmb < 1000){
        [array addObject:[NSString stringWithFormat:@"%d",mirmb]];
        if(maRmb <=10000){
            for(int i=0;i<maRmb/1000;i++){
                [array addObject:[NSString stringWithFormat:@"%d",i*1000]];
            }
        }else if (maRmb >10000&&maRmb<50000){
            
        }
    }else{
        if(maRmb <=10000){
            for(int i=0;i<maRmb/1000;i++){
                [array addObject:[NSString stringWithFormat:@"%d",i*1000]];
            }
        }else if (maRmb >10000&&maRmb<50000){
            
        }
    }
    
    return array;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
