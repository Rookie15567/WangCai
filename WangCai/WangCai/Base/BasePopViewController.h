//
//  BasePopViewController.h
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePopViewController : UIViewController

/**
 返回按键 可以自定义点击返回的事件

 @param but 按键
 */
-(void)doBack:(UIButton*)but;
/**
 自定义push方法

 @param viewController push到的ViewController
 @param ishiden        TabBar是否隐藏
 @param isAnimated     是否有动画
 */
+(void)selfPushViewControll:(UIViewController*)viewController tabbarHiden:(BOOL)ishiden animated:(BOOL)isAnimated;
@end
