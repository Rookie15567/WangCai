//
//  MeansTableViewCell.h
//  WangCai
//
//  Created by cds on 16/12/7.
//  Copyright © 2016年 cds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeansModel.h"
@protocol MeansDelagate;

typedef NS_OPTIONS(NSUInteger, CellClickType) {
    CellClickTextFileType = 0,
    CellClickPickType = 1,
    CellNOClickType = 2
};

@interface MeansTableViewCell : UITableViewCell
@property (nonatomic,strong) MeansModel * model;
@property (nonatomic,strong) YYLabel * Label;
@property (nonatomic,strong) YYLabel * chooseLabel;
@property (nonatomic,strong) UITextField * enterTextFile;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) NSString * plString;
@property (nonatomic,strong) NSString * textString;
@property (nonatomic,strong) UIImageView * line;
@property (nonatomic,strong) UIColor * textcolor;
@property (nonatomic,weak) id<MeansDelagate>delegate;
@property (nonatomic,assign)NSInteger NowIndex;
@end
@protocol MeansDelagate <NSObject>

-(void)textFileEndSelectCellTitle:(NSString*)title contentStr:(NSString*)contenStr Dict:(NSDictionary*)dic;
-(void)textFIleBegin:(UITextField*)tf;
@end
