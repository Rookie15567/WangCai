//
//  MeansModel.h
//  WangCai
//
//  Created by cds on 16/12/7.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeansModel : NSObject

/**
 类型
 */
@property (nonatomic,strong)NSString * type;
/**
 标题
 */
@property (nonatomic,strong)NSString * title;
/**
 详情
 */
@property (nonatomic,strong)NSString * detial;
/**
 提示文字
 */
@property (nonatomic,strong) NSString * plString;
@end
