//
//  myinfoFootView.m
//  LoanTool
//
//  Created by cds on 17/3/8.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "myinfoFootView.h"

@implementation myinfoFootView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        if(!_qqLabel){
            _qqLabel = [YYLabel new];
            //_qqLabel.backgroundColor = [UIColor redColor];
            _qqLabel.textColor = [RGBColor colorWithHexString:@"999999"];
            _qqLabel.text = @"客服QQ：2233334";
            _qqLabel.font = SYSTEM_FONT(14);
            _qqLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_qqLabel];
        }
        if(!_label){
            _label = [YYLabel new];
            _label.textColor = [RGBColor colorWithHexString:@"999999"];
            _label.text = @"QQ群：6868668";
            _label.font = SYSTEM_FONT(14);
            [self addSubview:_label];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-54*K_S_W);
        make.top.mas_equalTo(self.mas_top).with.offset(LABEL_TOP);
        make.height.mas_offset(14);
    }];
    [_qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(LABEL_TOP);
        make.right.mas_equalTo(_label.mas_left).with.offset(-20);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.height.mas_offset(14);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
