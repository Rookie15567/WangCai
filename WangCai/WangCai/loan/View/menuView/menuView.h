//
//  menuView.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuView : UIView
@property (nonatomic,strong)UIButton * oneButton;//激素借款
@property (nonatomic,strong)UIButton * twoButton;//大额
@property (nonatomic,strong)UIButton * threeButton;//办卡信用
@property (nonatomic,strong) YYLabel * oneLabel;
@property (nonatomic,strong) YYLabel * twoLabel;
@property (nonatomic,strong) YYLabel * threeLabel;
@property (nonatomic,strong)void (^butOnClickBlock)(NSString*string);
@end
