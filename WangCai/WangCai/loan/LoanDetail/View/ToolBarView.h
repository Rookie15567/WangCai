//
//  ToolBarView.h
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBarView : UIView
@property (nonatomic,strong)UIImageView * tagImageView;
@property (nonatomic,strong)UIView * back;
@property (nonatomic,strong)YYLabel * label;
@property (nonatomic,strong)void (^ToolBlock)(NSInteger num);
@end
