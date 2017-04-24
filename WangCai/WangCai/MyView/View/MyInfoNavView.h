//
//  MyInfoNavView.h
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavViewDelegate;
typedef NS_OPTIONS(NSUInteger, NavClickType) {
    NavNews = 0,
    NavHeadImage = 1,
    NavName = 2,
    HeadLoanView = 3
    
};

@interface MyInfoNavView : UIView<UIAlertViewDelegate>
-(void)changeHeadVIewImage:(UIImage*)image;
@property (nonatomic,assign)BOOL isNews;
@property (nonatomic,weak)id<NavViewDelegate>delegate;
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UIImageView * newsImageView; //消息
@property (nonatomic,strong)UIImageView * newsBackView;//为了使点击的区域变大
@property (nonatomic,strong)YYLabel * nameLabel;
@property (nonatomic,strong)YYLabel * typeLabel;
@property (nonatomic,strong)UIView * backTap;
@property (nonatomic,strong)UIImageView * tapImageView;
@end
@protocol NavViewDelegate <NSObject>
-(void)navViewOnClickType:(NavClickType )type Str:(NSString *)string;
@end
