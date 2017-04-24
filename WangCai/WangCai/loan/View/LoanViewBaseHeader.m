//
//  LoanViewBaseHeader.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanViewBaseHeader.h"
#define HEAD_VIEW_H 140*K_S_W
#define ADVER_VIEW_H 40*K_S_W
#define GAP_H 10*K_S_W
#define MENUVIEW_H  90*K_S_W
#define LOANVIEW_H 200*K_S_W
const CGFloat kNoticeLabelHeight = 12.0;
const CGFloat kNoticeLabelMargin = 5.0;
const CGFloat kNoticeImageViewWidth = 20.0;
@implementation LoanViewBaseHeader
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = UIColorHex(@"EEEEEE");
        _adArray = @[@"王* 刚在 51旺财 成功借款3000元",
                     @"陶** 刚在 51旺财 成功借款15000元",
                     @"严** 刚在 51旺财 成功借款5000元",
                     @"陆* 刚在 51旺财 成功借款18000元",
                     @"方* 刚在 51旺财 成功借款2000元",
                     @"钟** 刚在 51旺财 成功借款4000元",
                     @"王邱 刚在 51旺财 成功借款3000元",
                     @"孙** 刚在 51旺财 成功借款8000元",
                     @"赵* 刚在 51旺财 成功借款10000元",
                     @"邵* 刚在 51旺财 成功借款50000元",
                     @"江* 刚在 51旺财 成功借款6000元",
                     @"杨* 刚在 51旺财 成功借款5000元"];
        if(!_scrollView){
            _scrollView = [[ScrollHeadView alloc]init];
            _scrollView.pageControlPosition = PageControlPositionCenter;
            //_scrollView.imageUrls = @[@"last_5",@"last_5",@"last_5",@"last_5"];
            _scrollView.timeInterval = 2;
            _scrollView.delegate = self;
            [self addSubview:_scrollView];
            
        }
        if(!_adverView){
            _adverView = [[AdvertiseView alloc]initWithTitles:_adArray];
            _adverView.origin = CGPointMake(_noticeImageView.right+8, 0);
            _adverView.size = CGSizeMake(kScreenWidth-kNoticeLabelMargin*2-_noticeImageView.right, self.height);
            _adverView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _adverView.isHaveTouchEvent = YES;
            __weak typeof(self) weakSelf = self;
            _adverView.adClickBlock = ^(NSInteger k){
                [weakSelf adClickString:[NSString stringWithFormat:@"%ld",(long)k]];
            };
            _adverView.headImg = [UIImage imageNamed:@"bell"];
            [_adverView beginScroll];
            [self addSubview:_adverView];
        }
        if(!_menuView){
            _menuView = [[menuView alloc]init];
            __weak typeof(self) weakSelf = self;
            _menuView.butOnClickBlock = ^(NSString* str){
                [weakSelf menuButClick:str];
            };
            [self addSubview:_menuView];
        }
        if(!_loanView){
            _loanView = [[loanView alloc]init];
            __weak typeof(self) weakSelf = self;
            _loanView.butBlock = ^(NSString * str){
                [weakSelf loanButOnClick:str];
            };
            [self addSubview:_loanView];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    //_headImageView.frame =CGRectMake(0, 0, S_W, HEAD_VIEW_H);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.width.mas_equalTo(S_W);
        make.height.mas_equalTo(HEAD_VIEW_H);
    }];
   [_adverView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(_scrollView.mas_bottom).with.offset(0);
       make.height.mas_equalTo(ADVER_VIEW_H);
       make.width.mas_equalTo(S_W);
       make.left.equalTo(self.mas_left).with.offset(0);
   }];
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_adverView.mas_bottom).with.offset(GAP_H);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.height.mas_equalTo(MENUVIEW_H);
        make.width.mas_equalTo(S_W);
        
    }];
    [_loanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(_menuView.mas_bottom).with.offset(GAP_H);
        make.height.mas_equalTo(LOANVIEW_H);
        make.width.mas_equalTo(S_W);
    }];
    
}

/**
 菜单按钮

 @param str 区别三个按钮
 */
-(void)menuButClick:(NSString*)str{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headViewOnClickType:Str:)]){
        [self.delegate headViewOnClickType:HeadMenuView Str:str];
    }
}

/**
 钱数按钮
 @param tag 标签
 */
-(void)loanButOnClick:(NSString*)tag{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headViewOnClickType:Str:)]){
        [self.delegate headViewOnClickType:HeadLoanView Str:tag];
    }
}
/**
 滚动通知按钮

 @param str 区别消息
 */
-(void)adClickString:(NSString *)str{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headViewOnClickType:Str:)]){
        [self.delegate headViewOnClickType:HeadADView Str:str];
    }
}
-(void)setScrollerArr:(NSArray *)scrollerArr
{
    _scrollerArr = scrollerArr;
    _scrollView.imageUrls = _scrollerArr;
}
/**
 顶部点击
 */

-(void)setData:(NSArray*)imageArray{
    _headImageView.image = [UIImage imageNamed:@"pic_bg"];
//    _scrollView.imageUrls;
    NSMutableArray * arr = [NSMutableArray array];
    
    for(int i=0;i<imageArray.count ; i++){
        LoanModel * model = imageArray[i];
        [arr addObject:model.bannerpic];
    }
    _scrollView.imageUrls = arr;
    
    
    
}
-(void)scrollView:(NSArray* )urlArray
{
    _scrollView.imageUrls = urlArray;
}
-(void)setModel:(LoanModel *)model
{
    
}
#pragma mark - scrollViewdelegate
-(void)bannerScrollView:(ScrollHeadView *)bannerScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headViewOnClickType:Str:)]){
        [self.delegate headViewOnClickType:HeadScrollView Str:[NSString stringWithFormat:@"%ld",(long)index]];
    }
    NSLog(@"%ld",index);
}


@end
