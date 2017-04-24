//
//  InputVIew.m
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "InputVIew.h"
#define LABEL_FONT 14
@implementation InputVIew
-(instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 8;
        if(!_backImgView){

            _backImgView = [[UIImageView alloc]init];
            //_backImgView.backgroundColor = [UIColor clearColor];
            _backImgView.userInteractionEnabled = YES;
            _backImgView.layer.cornerRadius = 8;
            _backImgView.layer.borderWidth = 1.0f;
            _backImgView.layer.borderColor = [UIColor whiteColor].CGColor;
            [self addSubview:_backImgView];
        }
        if(!_tagLabel){
            _tagLabel = [YYLabel new];
            _tagLabel.textColor = [UIColor whiteColor];
            _tagLabel.font = [UIFont systemFontOfSize:LABEL_FONT];
            _tagLabel.text =@"手机：";
            
            [self addSubview:_tagLabel];
        }
        if(!_textFile){
            _textFile = [UITextField new];
            //_textFile.layer.cornerRadius= 8;
            _textFile.textColor = [UIColor whiteColor];
        
            [_backImgView addSubview:_textFile];
        }
    }
    return self;
}
//绘制 矩形

/*-(void)drawRect:(CGRect)rect
{
    CGRect drawRect = _backImgView.frame;
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
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        
    }];
   
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.left.mas_equalTo(_tagLabel.mas_right).with.offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
        
    }];

    
    [_textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backImgView).with.insets(UIEdgeInsetsMake(1, 10, 1, 1));
    }];
}
-(void)setTagString:(NSString *)tagString
{
    _tagString = tagString;
    _tagLabel.text = tagString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
