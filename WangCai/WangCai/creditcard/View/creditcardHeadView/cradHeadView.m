//
//  cradHeadView.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "cradHeadView.h"
#define HEADIMAGE_H 140 //顶部图片高度
#define TRENDLABEL_FONT 12
#define LINE_H 10
@implementation cradHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        if(!_barnnerImg){
            _barnnerImg = [UIImageView new];
            _barnnerImg.image = [UIImage imageNamed:@"card_banner"];
            [self addSubview:_barnnerImg];
        }
    //self.backgroundColor = [UIColor colorWithHexString:LINE_COLOR];
        self.backgroundColor = [UIColor whiteColor];
        if(!_headImageView){
            _headImageView = [[UIImageView alloc]init];
            _headImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
            [_headImageView addGestureRecognizer:tap];
            [self addSubview:_headImageView];
        }
        if(!_oneTrned){
            _oneTrned = [[trendHeadView alloc]init];
           // _oneTrned.backgroundColor = [UIColor redColor];
            _oneTrned.isShow = YES;
            __weak typeof(self) weakSelf = self;
            _oneTrned.trendBlock = ^(NSInteger a){
                [weakSelf oneCardClick];
            };
            //[_oneTrned isShowTitle:YES position:CardPositionLeft];
            [self addSubview:_oneTrned];
        }
        if(!_twoTrend){
            _twoTrend = [[trendHeadView alloc]init];
            //_twoTrend.backgroundColor = [UIColor greenColor];
            _twoTrend.isShow = NO;
            __weak typeof(self) weakSelf = self;
            _twoTrend.trendBlock = ^(NSInteger a){
                [weakSelf twoCardClick];
            };
           // [_twoTrend isShowTitle:NO position:CardPositionRight];
            [self addSubview:_twoTrend];
        }
        if(!_oneLineImageView){
            _oneLineImageView = [[UIImageView alloc]init];
            _oneLineImageView.backgroundColor = [UIColor colorWithHexString:LINE_COLOR];
            [self addSubview:_oneLineImageView];
        }
        if(!_twoLineImageView){
            _twoLineImageView = [[UIImageView alloc]init];
            _twoLineImageView.backgroundColor = [UIColor colorWithHexString:LINE_EEEEECOLOR];
            [self addSubview:_twoLineImageView];
        }
       
    }
    return self;
}
-(void)layoutSubviews
{
    [_barnnerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
        make.height.mas_offset(BANNER_H);
    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(BANNER_H);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(0);
    }];
    [_oneLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(0);
    }];
    [_oneTrned mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).with.offset(LINE_H);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(S_W/2);
    }];
    [_twoTrend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).with.offset(LINE_H);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(S_W/2);
    }];
   [_twoLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(LINE_H);
       make.width.mas_equalTo(S_W);
       make.left.equalTo(self.mas_left).with.offset(0);
       make.bottom.equalTo(self.mas_bottom).with.offset(0);
   }];
}
-(void)setData:(NSArray *)model{
    NSLog(@"mmmmmmm = %@",model);
    CredCardModel * mode1;
    CredCardModel * mode2;
    if(model.count >1){
    mode1 = model[0];
     mode2 = model[1];
    }
   // _headImageView.image = [UIImage imageNamed:@"last_5"];
    [_oneTrned.cardImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,mode1.logo]] placeholder:nil options:YYWebImageOptionProgressive completion:nil];
//    //image = [UIImage imageNamed:@"last_2"];
    [_twoTrend.cardImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",primAPI,mode2.logo]] placeholder:nil
                                     options:YYWebImageOptionProgressive completion:nil];
    //.image = [UIImage imageNamed:@"last_3"];
//    _oneTrned.titleLabel.text = mode1.name;//@"兴业星夜星座信用卡";
//    _oneTrned.detailLabel.text = mode1.info;//@"附带专属星座小卡";
//    NSLog(@"%@%@",mode1.info,mode1.name);
    _oneTrned.titleLabel.text = mode1.name;
    _oneTrned.detailLabel.text = mode1.info;
    _twoTrend.titleLabel.text = mode2.name;
    _twoTrend.detailLabel.text =mode2.info;
}
#pragma mark - CLICK
-(void)headClick{
    
}
-(void)oneCardClick{
    if(self.delegate &&[self.delegate respondsToSelector:@selector(headViewSelectType:)]){
        [self.delegate headViewSelectType:headTrendOne];
    }
}
-(void)twoCardClick{
    if(self.delegate &&[self.delegate respondsToSelector:@selector(headViewSelectType:)]){
        [self.delegate headViewSelectType:headTrendTwo];
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
