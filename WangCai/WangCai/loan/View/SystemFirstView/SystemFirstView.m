//
//  SystemFirstView.m
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "SystemFirstView.h"
#define INPUT_W 36*K_S_W
//#define TOP_H 258 * K_S_H
//#define TOP_H 200 //5s

#define LEFT_S 60*K_S_W

#define RIGHT_S 60*K_S_W
@interface SystemFirstView()
{
    NSMutableArray * _oneData;
    NSMutableArray * _cityData;
   
}

@property (nonatomic,strong) NSString * cityStr;
@property (nonatomic,strong) NSString * twocityStr;
@end
@implementation SystemFirstView
static int flag = 0;
static int TOP_H = 0;
static int BUTTON_TOP = 0;
-(instancetype)initWithFrame:(CGRect)frame
{
    self.userInteractionEnabled = YES;
    _cityData = [NSMutableArray array];
    if(self  = [super initWithFrame:frame]){
        if(!_backImageView){
            _backImageView = [[UIImageView alloc]initWithFrame:frame];
            _backImageView.image = [UIImage imageNamed:@"BackImg"];
            _backImageView.userInteractionEnabled = YES;
            [self addSubview:_backImageView];
        }
        if(!_nameInput){
            _nameInput = [InputVIew new];
            _nameInput.tagString = @"姓名：";
            _nameInput.backgroundColor = [UIColor clearColor];
            [self addSubview:_nameInput];
        }
        if(!_ageInput){
            _ageInput = [InputVIew new];
            _ageInput.tagString = @"年龄：";
            _ageInput.textFile.keyboardType = UIKeyboardTypeNumberPad;
            _ageInput.backgroundColor = [UIColor clearColor];
            [self addSubview:_ageInput];
            
        }
        if(!_sexPickView){
            _sexPickView = [FirstPickView new];
            _sexPickView.backgroundColor = [UIColor clearColor];
            _sexPickView.isHidetag = YES;
            _sexPickView.conLabel.text = @"男";
            _sexPickView.pickArray = @[@"男",@"女"];
            __weak typeof(self) weakSelf = self;
            _sexPickView.pickBlock = ^(NSString*str){
                weakSelf.cityStr = str;
                weakSelf.sexPickView.conLabel.text = str;
            };
            [self addSubview:_sexPickView];
        }
        if(!_distanceOnePickView){
            _distanceOnePickView = [FirstPickView new];
            _distanceOnePickView.isHidetag = NO;
            _distanceOnePickView.tagString = @"地域：";
            _oneData = [NSMutableArray array];
            [self obtaiCityData];
            _distanceOnePickView.pickArray = _oneData;
            _distanceOnePickView.backgroundColor = [UIColor clearColor];
            _distanceOnePickView.conLabel.text = @"省会";
            __weak typeof(self) weakSelf = self;
            _distanceOnePickView.pickBlock = ^(NSString*str){
                weakSelf.cityStr = str;
                [weakSelf jumpje];
            };
            [self addSubview:_distanceOnePickView];
        }
        if(!_distanceTwoPickView){
            _distanceTwoPickView = [FirstPickView new];
            _distanceTwoPickView.backgroundColor = [UIColor clearColor];
            _distanceTwoPickView.isHidetag = YES;
            _distanceTwoPickView.conLabel.text = @"城市";
            __weak typeof(self) weakSelf = self;
            _distanceTwoPickView.pickBlock = ^(NSString*str){
                weakSelf.twocityStr = str;
                weakSelf.distanceTwoPickView.conLabel.text = str;
                //[weakSelf jumpje];
            };
            [self addSubview:_distanceTwoPickView];
        }
        if(!_telNumInput){
            _telNumInput = [InputVIew new];
            _telNumInput.backgroundColor = [UIColor clearColor];
            _telNumInput.tagString = @"手机：";
            _telNumInput.textFile.keyboardType = UIKeyboardTypeNumberPad;
            [self addSubview:_telNumInput];
        }
        if(!_sureButton ){
            _sureButton = [[UIButton alloc]init];
            [_sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
            [_sureButton setBackgroundColor:[RGBColor colorWithHexString:@"ff5c5c"]];
            [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_sureButton setTitle:@"下一步" forState:UIControlStateNormal];
            _sureButton.layer.cornerRadius = 8;
            [self addSubview:_sureButton];
            
        }
        if(!_loanInput){
            _loanInput = [InputVIew new];
            _loanInput.backgroundColor = [UIColor clearColor];
            _loanInput.tagString = @"借款金额：";
            _loanInput.textFile.keyboardType = UIKeyboardTypeNumberPad;
            [self addSubview:_loanInput];
        }
        if(!_carPick){
            _carPick = [FirstPickView new];
            _carPick.backgroundColor = [UIColor clearColor];
            _carPick.isHidetag = NO;
            _carPick.tagLabel.text = @"汽车：";
            __weak typeof(self) weakSelf = self;
            _carPick.pickArray = @[@"是",@"否"];
            _carPick.conLabel.text = @"是";
            _carPick.pickBlock = ^(NSString*str){
                weakSelf.twocityStr = str;
                weakSelf.distanceTwoPickView.conLabel.text = str;
                //[weakSelf jumpje];
            };
            [self addSubview:_carPick];
        }
        if(!_cardPick){
            _cardPick = [FirstPickView new];
            _cardPick.backgroundColor = [UIColor clearColor];
            _cardPick.isHidetag = NO;
            _cardPick.tagLabel.text = @"信用卡：";
            _cardPick.pickArray = @[@"是",@"否"];
            _cardPick.conLabel.text = @"是";
            __weak typeof(self) weakSelf = self;
            _cardPick.pickBlock = ^(NSString*str){
                weakSelf.twocityStr = str;
                weakSelf.distanceTwoPickView.conLabel.text = str;
                //[weakSelf jumpje];
            };
            [self addSubview:_cardPick];
        }
        if(!_shebaoPick){
            _shebaoPick = [FirstPickView new];
            _shebaoPick.backgroundColor = [UIColor clearColor];
            _shebaoPick.isHidetag = NO;
            _shebaoPick.tagLabel.text = @"社保：";
            _shebaoPick.pickArray = @[@"是",@"否"];
            _shebaoPick.conLabel.text = @"是";
            __weak typeof(self) weakSelf = self;
            _shebaoPick.pickBlock = ^(NSString*str){
                weakSelf.twocityStr = str;
                weakSelf.distanceTwoPickView.conLabel.text = str;
                //[weakSelf jumpje];
            };
            [self addSubview:_shebaoPick];
        }
        [self oneStep];
    }
    return self;
}
-(void)sureClick{
    flag ++ ;
   // [self threeSeto];
    if(flag == 1){
   // NSLog(@"%@",_nameInput.textFile.text);
    if(_nameInput.textFile.text.length > 0 && _ageInput.textFile.text.length > 0&& _telNumInput.textFile.text.length > 10 ){
        [self twoSetp];
    }else{
        flag = 0;
        [MBProgressHUD showWithText:@"请正确输入信息" view:nil];
    }
    }else if (flag == 2){
        if(_loanInput.textFile.text.length >0){
        [self threeSeto];
        }else{
          [MBProgressHUD showWithText:@"请输入金额" view:nil];
        }
        flag = 0;
    }
    
    
}
-(void)obtaiCityData{
    NSString * file = [[NSBundle mainBundle] pathForResource:@"china" ofType:@"plist"];
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:file];
    //NSLog(@"dict ==   %@",dict);
    NSArray * array = dict[@"data"];
    for(int i=0;i<array.count;i++){
        [_oneData addObject:array[i][@"name"]];
        
    }
}
-(void)jumpje{
    
    NSArray * array = @[@"北京",@"上海",@"天津",@"重庆",@"台湾",@"香港",@"澳门"];
    for(int i=0;i<array.count;i++){
        if([_cityStr isEqualToString:array[i]]){
            _distanceTwoPickView.conLabel.text = @"";
            _distanceTwoPickView.pickArray = nil;
            break;
        }else{
           _distanceTwoPickView.conLabel.text = @"城市";
        }
    }
    NSString * file = [[NSBundle mainBundle] pathForResource:@"china" ofType:@"plist"];
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:file];
    //NSLog(@"dict ==   %@",dict);
    NSArray * arr = dict[@"data"];
    for(int i=0;i<arr.count;i++){
        if([arr[i][@"city"] count] >0){
        if([arr[i][@"name"] isEqualToString:_cityStr]){
           // NSLog(@"aaaa == %@",arr[i][@"city"]);
            
            for(int j=0;j<[arr[i][@"city"] count];j++){
               // NSLog(@"  cc   ==  %@",arr[i][@"city"][j][@"name"]);
                [_cityData addObject:arr[i][@"city"][j][@"name"]];
            }
        }
        }
    }
    _distanceTwoPickView.pickArray = _cityData;
}
-(void)layoutSubviews
{
    BUTTON_TOP = 40*K_S_H;
    if(IPHONE5_OR_5S){
        TOP_H = 200;
    }else if (IPHONE4_OR_4S){
        TOP_H = 160;
        BUTTON_TOP = 20;
    }else if(IPHONE6sP_OR_6p_OR_7P){
        TOP_H = 258*K_S_H;
    }else if (IPHONE6sP_OR_6p_OR_7P){
        TOP_H = 258*K_S_H;
    }else{
        TOP_H = 300*K_S_H;
    }
    NSLog(@"top ---  %d--%f",TOP_H,S_H);
    [_nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(TOP_H);
        make.left.mas_equalTo(self.mas_left).with.offset(60*K_S_W);
        make.right.mas_equalTo(self.mas_right).with.offset(-60*K_S_W);
        make.height.mas_offset(36*K_S_W);
    }];
    [_loanInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(TOP_H);
        make.left.mas_equalTo(self.mas_left).with.offset(60*K_S_W);
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(36);
    }];
    UILabel * lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = @"我的";
    CGSize size = [lab sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    [_sexPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
        make.top.mas_equalTo(_nameInput.mas_bottom).with.offset(10);
       // make.left.mas_equalTo(_ageInput.mas_right).with.offset(30);
        make.width.mas_offset(85*K_S_W);
    }];
    [_carPick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
        make.top.mas_equalTo(_nameInput.mas_bottom).with.offset(10);
        // make.left.mas_equalTo(_nameInput.mas_left).with.offset(0);
       // make.width.mas_offset(85);
        make.left.mas_equalTo(_loanInput.mas_left).with.offset(size.width);
        //make.left.mas_offset(90*K_S_W);
    }];
    [_ageInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameInput.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_nameInput.mas_left).with.offset(0);
        make.height.mas_offset(INPUT_W);
        make.right.mas_equalTo(_sexPickView.mas_left).with.offset(-30*K_S_W);
    }];
    [_distanceTwoPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
        make.top.mas_equalTo(_ageInput.mas_bottom).with.offset(10);
        
       // make.left.mas_equalTo(_ageInput.mas_right).with.offset(30);
        make.width.mas_offset(85*K_S_W);
    }];
    [_distanceOnePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ageInput.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_nameInput.mas_left).with.offset(0);
        make.right.mas_equalTo(_distanceTwoPickView.mas_left).with.offset(-30*K_S_W);
        make.height.mas_offset(INPUT_W);
    }];
    UILabel * lab1 = [UILabel new];
    lab1.font = [UIFont systemFontOfSize:14];
    lab1.text = @"我";
    CGSize size1 = [lab1 sizeThatFits:CGSizeMake(MAXFLOAT, 14)];
    [_cardPick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
        make.top.mas_equalTo(_carPick.mas_bottom).with.offset(10);
        
        make.left.mas_equalTo(_loanInput.mas_left).with.offset(size1.width);
        
    }];
    [_telNumInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_distanceOnePickView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_nameInput.mas_left).with.offset(0);
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
    }];
    [_shebaoPick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cardPick.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_carPick.mas_left).with.offset(0);
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(INPUT_W);
    }];
    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_telNumInput.mas_bottom).with.offset(BUTTON_TOP);
        make.left.mas_equalTo(_nameInput.mas_left).with.offset(0);
        make.right.mas_equalTo(_nameInput.mas_right).with.offset(0);
        make.height.mas_offset(44);
    }];
}
-(void)oneStep{
    _loanInput.hidden = YES;
    _carPick.hidden = YES;
    _cardPick.hidden = YES;
    _shebaoPick.hidden = YES;
}
-(void)twoSetp{
    _nameInput.hidden = YES;
    _ageInput.hidden = YES;
    _sexPickView.hidden = YES;
    _distanceOnePickView.hidden = YES;
    _distanceTwoPickView.hidden = YES;
    _telNumInput.hidden = YES;
    _loanInput.hidden = NO;
    _carPick.hidden = NO;
    _cardPick.hidden = NO;
    _shebaoPick.hidden = NO;
}
-(void)threeSeto{
    _nameInput.hidden = YES;
    _ageInput.hidden = YES;
    _sexPickView.hidden = YES;
    _distanceOnePickView.hidden = YES;
    _distanceTwoPickView.hidden = YES;
    _telNumInput.hidden = YES;
    _loanInput.hidden = YES;
    _carPick.hidden = YES;
    _cardPick.hidden = YES;
    _shebaoPick.hidden = YES;
    _sureButton.hidden = YES;
    int a = 0;
    int b =0;
    int c = 0;
    if(IPHONE5_OR_5S){
        a = 200;
        b = 290;
        c =340;
    }else if (IPHONE4_OR_4S){
        a = 170;
        b = 260;
        c =300;
    }else if(IPHONE6sP_OR_6p_OR_7P){
        a =240*K_S_H;
        b = 320*K_S_H;
        c =380*K_S_H;
    }else if (IPHONE6sP_OR_6p_OR_7P){
        a =240*K_S_H;
        b = 320*K_S_H;
        c =380*K_S_H;
    }else{
       
    }
    UIImageView * riImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, a, 60, 60)];
    riImage.center = CGPointMake(S_W/2, riImage.center.y);
    riImage.image = [UIImage imageNamed:@"Right"];
    UILabel * oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, b, S_W, 24)];
    oneLabel.textColor = [UIColor whiteColor];
    oneLabel.font = [UIFont systemFontOfSize:24];
    oneLabel.text = @"成功申请借款";
    oneLabel.textAlignment = NSTextAlignmentCenter;
    UILabel * twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, c, S_W, 14)];
    twoLabel.textColor = [UIColor whiteColor];
    twoLabel.font = [UIFont systemFontOfSize:14];
    twoLabel.text = @"若符合条件，借款顾问将会在";
    twoLabel.textAlignment = NSTextAlignmentCenter;
    UILabel * threeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, twoLabel.frame.origin.y + 14 + 10, S_W, 14)];
    threeLabel.textColor = [UIColor whiteColor];
    threeLabel.font = [UIFont systemFontOfSize:14];
    threeLabel.text = @"工作时间内24小时内联系您";
    threeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:riImage];
    [self addSubview:oneLabel];
    [self addSubview:twoLabel];
    [self addSubview:threeLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
