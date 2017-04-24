//
//  CardListModel.h
//  WangCai
//
//  Created by cds on 17/1/4.
//  Copyright © 2017年 cds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardListModel : NSObject
@property (nonatomic,strong)NSString * addTime;
@property (nonatomic,strong)NSString * clickNum; //点击次数
@property (nonatomic,strong)NSString * flag; //是否显示
@property (nonatomic,strong)NSString * h5; //h5链接
@property (nonatomic,strong)NSString * h52;//进度查询
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * info;
@property (nonatomic,strong)NSString * listflag; //是否有列表
@property (nonatomic,strong)NSString * logo;
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * sort;
@property (nonatomic,strong)NSString * usernum;
@end
