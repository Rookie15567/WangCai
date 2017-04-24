//
//  FirstPickView.m
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "FirstPickView.h"
#import "DQconstellationView.h"
@interface FirstPickView ()<DQconstellationViewDelegate>
@property (nonatomic, strong) DQconstellationView *DQconstellationView;
@property (nonatomic,strong) UIButton * tapButton;
@end
#define LABEL_FONT 14
@implementation FirstPickView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        if(!_DQconstellationView){
            self.DQconstellationView = [DQconstellationView new];
            self.DQconstellationView.delegate = self;
            
            //[self addSubview:_DQconstellationView];
        }
        self.userInteractionEnabled = YES;
        
        if(!_tagLabel){
            _tagLabel = [YYLabel new];
            _tagLabel.text = @"sada";
            _tagLabel.userInteractionEnabled = YES;
            _tagLabel.textColor = [UIColor whiteColor];
            _tagLabel.font = [UIFont systemFontOfSize:LABEL_FONT];
            [self addSubview:_tagLabel];
        }
        if(!_conLabel){
            _conLabel = [YYLabel new];
            _conLabel.userInteractionEnabled = YES;
            _conLabel.textColor = [UIColor whiteColor];
            _conLabel.font = [UIFont systemFontOfSize:LABEL_FONT];
           
            [self addSubview:_conLabel];
        }
        if(!_triangleImg){
            _triangleImg = [UIImageView new];
            _triangleImg.image = [UIImage imageNamed:@"Triangle"];
            [self addSubview:_triangleImg];
        }
        if(!_backImage){
            _backImage = [UIImageView new];
            _backImage.userInteractionEnabled = YES;
            _backImage.layer.cornerRadius =8;
            _backImage.layer.borderWidth = 1.0f;
            _backImage.layer.borderColor = [UIColor whiteColor].CGColor;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick)];
            [_backImage addGestureRecognizer:tap];
            
            [self addSubview:_backImage];
        }
    }
    return self;
}
/*
-(void)drawRect:(CGRect)rect
{
    CGRect drawRect = _backImage.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:8];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextStrokePath(context);
    // self.backgroundColor = [UIColor redColor];
}*/
-(void)layoutSubviews
{
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
    if(_isHidetag){
        [_backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).with.offset(0);
            make.left.mas_equalTo(_tagLabel.mas_left).with.offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
            make.right.mas_equalTo(self.mas_right).with.offset(0);
        }];
    }else{
        [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).with.offset(0);
            make.left.mas_equalTo(_tagLabel.mas_right).with.offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
            make.right.mas_equalTo(self.mas_right).with.offset(0);
            
        }];
    }
    
    [_conLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backImage).with.insets(UIEdgeInsetsMake(1, 10, 1, 1));
    }];
    [_triangleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backImage.mas_centerY).with.offset(0);
        
        make.right.mas_equalTo(self.mas_right).with.offset(-13*K_S_W);
        make.width.offset(13*K_S_W);
        make.height.offset(13*K_S_W);
    }];
}
-(void)setPickArray:(NSArray *)pickArray
{
    _pickArray = pickArray;
    if(_DQconstellationView){
        _DQconstellationView.SourceArray = _pickArray;
        
    }
}
-(void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str
{
    
        if(self.pickBlock){
            self.pickBlock(str);
            _conLabel.text = str;
        }
    NSLog(@"pick === %@",str);
    
}

-(void)setIsHidetag:(BOOL)isHidetag
{
    _isHidetag = isHidetag;
    if(isHidetag){
        _tagLabel.hidden = YES;
        
    }else{
        _tagLabel.hidden = NO;
        
    }
}
-(void)setTagString:(NSString *)tagString
{
    _tagString = tagString;
    _tagLabel.text = tagString;
}

-(void)TapClick{
    if(_pickArray.count && _pickArray.count > 0){
    [self.DQconstellationView startAnimationFunction];
        
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
