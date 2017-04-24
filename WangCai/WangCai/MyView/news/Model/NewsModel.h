//
//  NewsModel.h
//  WangCai
//
//  Created by cds on 16/12/28.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/**
 h5url
 */
@property (nonatomic,strong) NSString * url;
/**
 标题
 */
@property (nonatomic,strong) NSString * title;
/**
 来源
 */
@property (nonatomic,strong) NSString * source;
@end
