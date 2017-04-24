//
//  FirstPickView.h
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPickView : UIView
@property (nonatomic,strong) YYLabel * tagLabel;
@property (nonatomic,strong) UIImageView * backImage;
@property (nonatomic,strong ) YYLabel * conLabel;
@property (nonatomic,strong) UIImageView * triangleImg;

@property (nonatomic,strong) NSArray* pickArray;
@property (nonatomic,strong) void (^pickBlock)(NSString*str);
@property (nonatomic,assign) BOOL isHidetag;
@property (nonatomic,strong) NSString * tagString;
@end
