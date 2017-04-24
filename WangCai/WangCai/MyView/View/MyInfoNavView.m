//
//  MyInfoNavView.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "MyInfoNavView.h"

#define TITLE_FONT 18
#define NAME_FONT 12
#define HEAD_SIZE 60
#define HEAD_TOP 45
#define HEAD_LEFT 15
#define TITLE_HEAD_W 4
#define TITLE_TOP 54
#define NAME_TITLE_TOP 8
#define NAME_HEAD_W 6
#define NEWS_SIZE_W 24
#define NEWS_SIZE_H 26
#define NEWS_RIGHT 19
@interface MyInfoNavView ()

@end
@implementation MyInfoNavView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
        self.userInteractionEnabled = YES;
        if(!_headImageView){
            _headImageView = [UIImageView new];
            //_headImageView.backgroundColor = [UIColor redColor];
            _headImageView.layer.masksToBounds = YES;
            //UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
            _headImageView.userInteractionEnabled = YES;
            //[_headImageView addGestureRecognizer:tap];
            [self addSubview:_headImageView];
        }
        if(!_newsImageView){
            _newsImageView= [UIImageView new];
            _newsImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(news)];
            [_newsImageView addGestureRecognizer:tap];
            [self addSubview:_newsImageView];
        }
        if(!_newsBackView){
            _newsBackView = [UIImageView new];
            _newsBackView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(news)];
            [_newsBackView addGestureRecognizer:tap];
            [self addSubview:_newsBackView];
        }
        if(!_nameLabel){
            _nameLabel = [YYLabel new];
            _nameLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:TITLE_FONT];
            _nameLabel.textColor = [UIColor whiteColor];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nameClick)];
            [_nameLabel addGestureRecognizer:tap];
            
            [self addSubview:_nameLabel];
        }
        if(!_typeLabel){
            _typeLabel = [YYLabel new];
            _typeLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:NAME_FONT];
            _typeLabel.textColor = [UIColor whiteColor];
            [self addSubview:_typeLabel];
        }
        if(!_tapImageView){
            _tapImageView = [UIImageView new];
            _tapImageView.backgroundColor = [RGBColor colorWithHexString:@"FF9933"];
            [_newsImageView addSubview:_tapImageView];
        }
        if(!_backTap){
            _backTap = [UIView new];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
            //_backTap.userInteractionEnabled = YES;
            [_backTap addGestureRecognizer:tap];
            [self addSubview:_backTap];
        }
    }
    return self;
}
-(void)setIsNews:(BOOL)isNews
{
    _isNews = isNews;
    if(isNews){
        _tapImageView.hidden = NO;
    }else{
        _tapImageView.hidden = YES;
    }
}
-(void)layoutSubviews
{
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(HEAD_TOP);
        make.left.equalTo(self.mas_left).with.offset(HEAD_LEFT);
        make.height.mas_equalTo(HEAD_SIZE);
        make.width.mas_equalTo(HEAD_SIZE);
    }];
    [_backTap mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(HEAD_TOP);
        make.left.equalTo(self.mas_left).with.offset(HEAD_LEFT);
        make.height.mas_equalTo(HEAD_SIZE);
        make.width.mas_equalTo(HEAD_SIZE);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.mas_top).with.offset(TITLE_TOP);
        make.left.equalTo(_headImageView.mas_right).with.offset(TITLE_HEAD_W);
        make.height.mas_equalTo(TITLE_FONT);
        make.centerY.mas_equalTo(_headImageView.mas_centerY).with.offset(0);
    }];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(NAME_TITLE_TOP);
        make.left.equalTo(_headImageView.mas_right).with.offset(NAME_HEAD_W);
        make.height.mas_equalTo(0);
    }];
    [_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel.mas_centerY).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-NEWS_RIGHT);
        make.height.mas_equalTo(NEWS_SIZE_H);
        make.width.mas_equalTo(NEWS_SIZE_H);
    }];
    [_newsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel.mas_centerY).with.offset(0);
        make.centerX.equalTo(_newsImageView.mas_centerX).with.offset(0);
        make.height.mas_equalTo(NEWS_SIZE_H+20);
        make.width.mas_equalTo(NEWS_SIZE_H+20);
    }];
    _newsImageView.image = [UIImage imageNamed:@"news"];
    [_tapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.centerX.equalTo(_newsImageView.mas_right).with.offset(0);
        make.centerY.equalTo(_newsImageView.mas_top).with.offset(0);
    }];
    _tapImageView.layer.cornerRadius = 3;
}
-(void)changeHeadVIewImage:(UIImage*)image{
    //_typeLabel.text = @"类型";
    _nameLabel.text = @"昵称";
    //_headImageView.layer.cornerRadius = HEAD_SIZE/2;
    _headImageView.image = image;//[UIImage imageNamed:@"text"];
    _headImageView.layer.cornerRadius = HEAD_SIZE/2;
    //存本地
}
-(void)setHeadImageView:(UIImageView *)headImageView
{
    _headImageView = headImageView;
}
-(void)news{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(navViewOnClickType:Str:)]){
        [self.delegate navViewOnClickType:NavNews Str:nil];
    }
}
-(void)tapClick{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(navViewOnClickType:Str:)]){
        [self.delegate navViewOnClickType:NavHeadImage Str:nil];
    }
   // [self UesrImageClicked];
    //跳转到相机或相册页面
   
}
- (void)UesrImageClicked
{
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate: self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    
    [sheet showInView:self];
}
#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([UIImagePickerController
            isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {             switch (buttonIndex) {
            case 0:
                return;
            case 1: //相机
                sourceType = UIImagePickerControllerSourceTypeCamera;                     break;
            case 2: //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;                     break;
        }
        }
        else
        {
            if (buttonIndex == 0){
                return;
            } else {
                @try {
                    
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
                sourceType =
                UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        if(self.delegate&&[self.delegate respondsToSelector:@selector(navViewOnClickType:Str:)]){
            [self.delegate navViewOnClickType:NavHeadImage Str:[NSString stringWithFormat:@"%lu",(unsigned long)sourceType]];
        }
    }
}


-(void)nameClick{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(navViewOnClickType:Str:)]){
        [self.delegate navViewOnClickType:NavName Str:@""];
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
