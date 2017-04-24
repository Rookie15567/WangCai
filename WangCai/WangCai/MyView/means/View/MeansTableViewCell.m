//
//  MeansTableViewCell.m
//  WangCai
//
//  Created by cds on 16/12/7.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "MeansTableViewCell.h"
#import "DQconstellationView.h"
@interface MeansTableViewCell ()<UITextFieldDelegate,DQconstellationViewDelegate>
@end
#define LABEL_LEFT 30
#define LAbEL_FONT 12
#define TEXT_RIGHT 20


@implementation MeansTableViewCell
-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    
}
-(void)setTextcolor:(UIColor *)textcolor
{
    _textcolor = textcolor;
    _chooseLabel.textColor = textcolor;
}
-(void)setPlString:(NSString *)plString
{
    _plString = plString;
    _chooseLabel.text = plString;
}
-(void)setTextString:(NSString *)textString
{
    _textString = textString;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.enterTextFile addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
        if(!_Label){
            _Label = [YYLabel new];
            _Label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LAbEL_FONT];
            _Label.textColor = [RGBColor colorWithHexString:TEXT_BLACKCOLOR];
            [self addSubview:_Label];
        }
        if(!_enterTextFile){
            _enterTextFile = [[UITextField alloc]init];
            _enterTextFile.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LAbEL_FONT];
            _enterTextFile.delegate = self;
            _enterTextFile.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
                    _enterTextFile.textAlignment = NSTextAlignmentRight;
            [self addSubview:_enterTextFile];
        }
        if(!_line){
            _line = [UIImageView new];
            _line.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
            [self addSubview:_line];
        }
        if(!_chooseLabel){
            _chooseLabel = [YYLabel new];
            _chooseLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:LAbEL_FONT];
            _chooseLabel.textColor = [RGBColor colorWithHexString:TEXT_PLCCCCCOLOR];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickClick)];
            [_chooseLabel addGestureRecognizer:tap];
            [self addSubview:_chooseLabel];
        }
    }
    return self;
}
-(void)pickClick{
    
}
-(void)layoutSubviews
{
    [_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(LABEL_LEFT);
        make.height.mas_equalTo(LAbEL_FONT);
    }];
    
    [_chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(_Label.mas_centerY).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-TEXT_RIGHT);
        make.height.mas_equalTo(LAbEL_FONT);
        
    }];
            CGFloat hei =[self widthOfString:@"1222222222222222222" font:_enterTextFile.font height:LAbEL_FONT];
            [_enterTextFile mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_Label.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-TEXT_RIGHT);
                make.height.mas_equalTo(LAbEL_FONT);
                make.width.mas_equalTo(hei);
                // make.width.mas_equalTo(_chooseLabel);
            }];
    [_enterTextFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_Label.mas_centerY).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-TEXT_RIGHT);
        make.height.mas_equalTo(LAbEL_FONT);
        make.width.mas_equalTo(200);
       // make.width.mas_equalTo(_chooseLabel);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(S_W);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
}
-(void)setModel:(MeansModel *)model
{
    _model = model;
    _Label.text = model.title;
    if([model.type isEqualToString:@"3"]){
        _enterTextFile.hidden = YES;
        _chooseLabel.hidden = NO;
        _chooseLabel.text = @"请选择";
    }else{
        _enterTextFile.hidden = NO;
        _chooseLabel.hidden = YES;
        if(model.detial.length ==0 || model.detial == nil){
        _enterTextFile.placeholder = model.plString;
            
        }
        else{
            
            _enterTextFile.text = model.detial;
        }
//        CGFloat hei =[self widthOfString:model.plString font:_enterTextFile.font height:LAbEL_FONT];
//        [_enterTextFile mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(_Label.mas_centerY).with.offset(0);
//            make.right.equalTo(self.mas_right).with.offset(-TEXT_RIGHT);
//            make.height.mas_equalTo(LAbEL_FONT);
//            make.width.mas_equalTo(hei);
//            // make.width.mas_equalTo(_chooseLabel);
//        }];
    }
    if([model.title isEqualToString:@"手机号"] || [model.title isEqualToString:@"身份证"]){
        _enterTextFile.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        _enterTextFile.keyboardType = UIKeyboardTypeDefault;

    }
}
-(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
         NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
         CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
         return rect.size.width;
}
-(void)setNowIndex:(NSInteger)NowIndex
{
    NSLog(@"nowindex == %ld",NowIndex);
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(textFIleBegin:)])
    {
        [self.delegate textFIleBegin:textField];
    }
    NSLog(@"tag  ===  %@",textField.tag);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.detial = textField.text;
    NSDictionary * mdict = [_model modelToJSONObject];
    if(self.delegate &&[self.delegate respondsToSelector:@selector(textFileEndSelectCellTitle:contentStr:Dict:)]){
        [self.delegate textFileEndSelectCellTitle:_model.title contentStr:textField.text Dict:mdict];
    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField == _enterTextFile) {
//        if([textField.placeholder isEqualToString:@"手机号"]){
//            if (textField.text.length > 11) {
//                return NO;
//            }
//            else{
//                return YES;
//            }
//        }else if([textField.placeholder isEqualToString:@"身份证"]){
//            if (textField.text.length > 18) {
//                return NO;
//            }
//            else{
//                return YES;
//            }
//        }
//        
//        
//    }
//    
//    return YES;
//}

-(void)setDataArray:(NSArray*)array{
    
}
-(void)textLengthChange:(id)sender
{
    UITextField *textfile = (UITextField*)sender;
    NSString * temp = textfile.text;
    if(temp.length > 11){
    
    }else{
        
    }
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
