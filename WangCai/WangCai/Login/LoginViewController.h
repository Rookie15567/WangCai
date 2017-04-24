//
//  LoginViewController.h
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoard.h"

@protocol LoginIsReach;
@interface LoginViewController : UIViewController

@property (nonatomic,strong)NSString * isReash;
@property (nonatomic,weak)id<LoginIsReach>delegate;
@end
@protocol LoginIsReach <NSObject>

-(void)selfViewDissMiss:(UIView *)view;

@end
