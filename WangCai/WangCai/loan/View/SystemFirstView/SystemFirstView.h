//
//  SystemFirstView.h
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputVIew.h"
#import "FirstPickView.h"
@interface SystemFirstView : UIView
@property (nonatomic ,strong) UIImageView * backImageView;
//@property (nonatomic ,strong)
@property (nonatomic,strong) InputVIew * nameInput;
@property (nonatomic,strong) InputVIew * ageInput;

/**
 性别
 */
@property (nonatomic,strong) FirstPickView * sexPickView;
@property (nonatomic,strong)FirstPickView * distanceOnePickView;
@property (nonatomic,strong)FirstPickView * distanceTwoPickView;
@property (nonatomic,strong) InputVIew * telNumInput;

@property (nonatomic,strong) InputVIew * loanInput;
@property (nonatomic,strong) FirstPickView * carPick;
@property (nonatomic,strong) FirstPickView * cardPick;
@property (nonatomic,strong) FirstPickView * shebaoPick;

@property (nonatomic,strong) UIButton * sureButton;
@end
