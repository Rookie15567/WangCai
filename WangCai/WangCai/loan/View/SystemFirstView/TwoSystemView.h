//
//  TwoSystemView.h
//  WangCai
//
//  Created by cds on 17/2/13.
//  Copyright © 2017年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputVIew.h"
#import "FirstPickView.h"
@interface TwoSystemView : UIView
@property (nonatomic,strong) InputVIew * loanInput;
@property (nonatomic,strong) FirstPickView * carPick;
@property (nonatomic,strong) FirstPickView * cardPick;
@property (nonatomic,strong) FirstPickView * shebaoPick;

@end
