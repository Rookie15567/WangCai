//
//  LoginBackView.h
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginBackView : UIView
@property (nonatomic,strong) UITextField * enterTextFile;
@property (nonatomic,strong) UITextField * secretTextFile;
@property (nonatomic,strong) UIImageView * enterImageView;
@property (nonatomic,strong) UIImageView * secretImageView;
@property (nonatomic,strong) UIImageView * enterLine;
@property (nonatomic,strong) UIImageView * secretLine;

@property (nonatomic,strong) YYLabel * testButton;
@property (nonatomic,strong) UIView * sureView;
@property (nonatomic,strong) UIImageView * logoImage;
@property (nonatomic,strong) YYLabel * sureLabel;
@property (nonatomic,strong) void (^tetBlock)(NSInteger n);
@end
