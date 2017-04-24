//
//  SystemTwoView.h
//  WangCai
//
//  Created by cds on 17/3/1.
//  Copyright © 2017年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headView.h"
#import "ScrollHeadView.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"

@protocol systemClickdelegate;

@interface SystemTwoView : UIView

@property (nonatomic,weak) id <systemClickdelegate>delegate;

@end
@protocol systemClickdelegate <NSObject>

-(void)tableClickUrl:(NSString*)url;
-(void)headClickUrl:(NSString*)url;

@end
