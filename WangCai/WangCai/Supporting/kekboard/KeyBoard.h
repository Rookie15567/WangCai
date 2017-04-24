//
//  KeyBoard.h
//  WangCai
//
//  Created by cds on 16/12/8.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, keyClickType) {
    keySureClickType = 0, //确定
    keyLeftClickType = 1, //左
    keyRightClickType = 2 //右
};//键盘顶部的
@protocol keyBoardDelegate;
@interface KeyBoard : UIView

/**
 确定按键
 */
@property (nonatomic,strong) UIButton * sureButton;
@property (nonatomic,strong) YYLabel * contentLabel; //键盘中间显示
/**
 左按键
 */
@property (nonatomic,strong) UIButton * leftButton;

/**
 有按键
 */
@property (nonatomic,strong) UIButton * rightButton;
@property (nonatomic,weak)id <keyBoardDelegate>delegate;
@property (nonatomic,strong) NSString * contentString;//键盘中间显示
@end
@protocol keyBoardDelegate <NSObject>

-(void)sureClick:(keyClickType)type;

@end
