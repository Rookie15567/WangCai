//
//  AdvertiseView.m
//  WinTreasure
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "AdvertiseView.h"

#define ViewWidth  self.bounds.size.width
#define ViewHeight  self.bounds.size.height
#define kNoticeImageViewWidth 20.0

@interface AdvertiseView ()<UIScrollViewDelegate>

/**文字前面的图标
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**轮流显示的两个Label
 */
@property (nonatomic, strong) YYLabel *oneLabel;
@property (nonatomic, strong) YYLabel *twoLabel;
@property (nonatomic, strong) YYLabel *one_oneLabel;
@property (nonatomic, strong) YYLabel *two_oneLabel;
/**计时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation AdvertiseView {
    NSUInteger index;
    CGFloat margin;
    BOOL isBegin;
}
- (instancetype)initWithTitles:(NSArray *)titles{
    self = [super init];
    if (self) {
        margin = 0;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.adTitles = titles;
        self.headImg = nil;
        self.labelFont = [UIFont systemFontOfSize:12];
        self.color = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
        self.time = 3.5f;
        self.textAlignment = NSTextAlignmentLeft;
        self.isHaveTouchEvent = YES;
        self.edgeInsets = UIEdgeInsetsZero;
        index = 0;
        
        if (!_headImageView) {
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kNoticeImageViewWidth, kNoticeImageViewWidth)];
            _headImageView.image = [UIImage imageNamed:@"bell"];
            [self addSubview:_headImageView];
        }
        
        if (!_oneLabel) {
            _oneLabel = [YYLabel new];
            if (self.adTitles.count > 0) {
                _oneLabel.text = [NSString stringWithFormat:@"%@",self.adTitles[index]];
            }
            _oneLabel.font = self.labelFont;
            _oneLabel.textAlignment = self.textAlignment;
            _oneLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            [self addSubview:_oneLabel];
        }
        
        if (!_twoLabel) {
            _twoLabel = [YYLabel new];
            _twoLabel.font = self.labelFont;
            _twoLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
            _twoLabel.textAlignment = self.textAlignment;
            [self addSubview:_twoLabel];
        }
    
    }
    return self;
}

- (void)timeRepeat{
   // NSLog(@"%lu",(unsigned long)index);
    if (self.adTitles.count <= 1) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    __block YYLabel *currentLabel;
    __block YYLabel *hidenLabel;
    __weak typeof(self) weakself = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[YYLabel class]]) {
            YYLabel *label = obj;
            NSString * string = weakself.adTitles[index];
            if ([label.text isEqualToString:string]) {
                currentLabel = label;
            }else{
                hidenLabel = label;
            }
        }
    }];
    
    if (index != self.adTitles.count-1) {
        index++;
    }else{
        index = 0;
    }
    
    hidenLabel.text = [NSString stringWithFormat:@"%@",self.adTitles[index]];
    [UIView animateWithDuration:1 animations:^{
        hidenLabel.frame = CGRectMake(margin, 0, ViewWidth, ViewHeight);
        currentLabel.frame = CGRectMake(margin, -ViewHeight, ViewWidth, ViewHeight);
    } completion:^(BOOL finished){
        currentLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth, ViewHeight);
    }];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //_headImageView.frame = CGRectMake(0, self.edgeInsets.top, kNoticeImageViewWidth, kNoticeImageViewWidth);
    if(_headImg){
        //NSLog(@"%f",self.frame.size.height);
        //_headImageView.frame = CGRectMake(10, 0, kNoticeImageViewWidth, kNoticeImageViewWidth);
        _headImageView.center = CGPointMake(_headImageView.center.x, self.frame.size.height/2);
        margin = CGRectGetMaxX(self.headImageView.frame) +10;
        NSLog(@"%@",self.headImageView);
        margin = self.headImageView.frame.size.width+self.headImageView.frame.origin.x +10;
    }else{
        
    }
    self.oneLabel.frame = CGRectMake(margin, 0, ViewWidth, ViewHeight);
    self.twoLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth, ViewHeight);
}


- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(timeRepeat) userInfo:self repeats:YES];
    }
    return _timer;
}


- (void)beginScroll{
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)closeScroll{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
}

- (void)setIsHaveTouchEvent:(BOOL)isHaveTouchEvent{
    if (isHaveTouchEvent) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }else{
        self.userInteractionEnabled = NO;
    }
}

- (void)setTime:(NSTimeInterval)time{
    _time = time;
    if (self.timer.isValid) {
        [self.timer isValid];
        self.timer = nil;
    }
}

- (void)setHeadImg:(UIImage *)headImg{
    _headImg = headImg;
    self.headImageView.image = headImg;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    self.oneLabel.textAlignment = _textAlignment;
    self.twoLabel.textAlignment = _textAlignment;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    //self.oneLabel.textColor = _color;
    //self.twoLabel.textColor = _color;
}

- (void)setLabelFont:(UIFont *)labelFont{
    _labelFont = labelFont;
    self.oneLabel.font = _labelFont;
    self.twoLabel.font = _labelFont;
}

- (void)clickEvent:(UITapGestureRecognizer *)tapGestureRecognizer{
    [self.adTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        if (index % 2 == 0 && [self.oneLabel.text isEqualToString:obj]) {
            if (self.clickAdBlock) {
                self.clickAdBlock(index);
            }
            if(self.adClickBlock){
                self.adClickBlock(index);
            }
        }else if(index % 2 != 0 && [self.twoLabel.text isEqualToString:obj]){
            if (self.clickAdBlock) {
                self.clickAdBlock(index);
            }
            if(self.adClickBlock){
                self.adClickBlock(index);
            }
        }
    }];
}

-(NSMutableAttributedString*)oldStr:(NSString*)str NAme:(NSString*)name changeTypeStr:(NSString*)chStr money:(NSString *)money{
    //是**刚在是大法官成功借款3000元
    NSRange rangeA = [str rangeOfString:name];
    NSRange rangeB = [str rangeOfString:@"刚在"];
    NSRange rangeC = [str rangeOfString:chStr];
    NSRange rangeD = [str rangeOfString:@"成功借款"];
    NSRange rangeE = [str rangeOfString:money];
    
     // 3.将 1.中创建的字符串生成可自由设置的 NSMutableAttributedString
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 4.给每一部分分别设置颜色
    [aStr addAttribute:NSForegroundColorAttributeName value:_color range:rangeA];
    [aStr addAttribute:NSForegroundColorAttributeName value:_color range:rangeB];
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:rangeC];
    [aStr addAttribute:NSForegroundColorAttributeName value:_color range:rangeD];
    [aStr addAttribute:NSForegroundColorAttributeName value:_color range:rangeE];
    // 5.分别设置字体
//    [aStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:25] range:rangeA];
//    [aStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:25] range:rangeB];
//    [aStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:25] range:rangeC];
    return aStr;
}
@end
