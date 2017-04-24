//
//  PickFrameView.h
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickFrameView : UIView
typedef enum {
    pickOne = 0,
    pickTwo
}pickType;
/**
 标题图片
 */
@property(nonatomic,strong)UIImage * tagImage;

/**
 标题图片
 */
@property (nonatomic,strong)UIImageView * tagImageView;

@property (nonatomic,strong)NSString * contentString;
@property (nonatomic,strong)YYLabel * conLabel;
@property(nonatomic,strong) UIView * backView;
@property (nonatomic,strong)UIImageView * tailImageView;
@property (nonatomic,strong) NSArray* pickArray;
@property (nonatomic,assign) NSInteger selectRow;
@property (nonatomic,strong)NSString * selectStr;
@property (nonatomic,strong) void (^pickBlock)(NSString*str);
@end
