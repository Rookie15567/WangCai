//
//  SystemTwoView.m
//  WangCai
//
//  Created by cds on 17/3/1.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "SystemTwoView.h"

@interface SystemTwoView()<UITableViewDelegate,UITableViewDataSource,ScrollViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
}
@property (nonatomic,strong)ScrollHeadView * headView;
@end
@implementation SystemTwoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self createUI];
        [self createDataSource];
    }
    return self;
}
//创建数据
-(void)createDataSource{
    _dataSource = [NSMutableArray array];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"messageList" ofType:@"plist"];
    NSDictionary * data = [[NSDictionary alloc]initWithContentsOfFile:path];
    //NSLog(@"%@",data);
    for(int i=0;i<[data[@"data"][@"net"] count];i++){
        
        NewsModel * model = [NewsModel modelWithDictionary:data[@"data"][@"net"][i]];
        [_dataSource addObject:model];
    }
    for(int i=0;i<[data[@"data"][@"card"] count];i++){
        
        NewsModel * model = [NewsModel modelWithDictionary:data[@"data"][@"card"][i]];
        [_dataSource addObject:model];
    }
}

-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-64-kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headView= [[ScrollHeadView alloc]initWithFrame:CGRectMake(0, 0, S_W, 120)];
    _tableView.tableHeaderView = _headView;
    _headView.pageControlPosition = PageControlPositionCenter;
    _headView.imageUrls = @[@"00-1.jpg",@"000-2.jpg"];
    _headView.timeInterval = 2;
    _headView.noUrl = @"1";
    __weak typeof(self) weakself = self;
    _headView.bannerItemClick = ^(NSInteger f){
        [weakself pushwebView:f];
    };
    _headView.delegate = self;
    [self addSubview:_tableView];
}
-(void)pushwebView:(NSInteger)k{
    NSArray * urlArr = @[@"http://money.sohu.com/20161224/n476798848.shtml",@"http://www.haodai.com/zixun/146854.html"];
    BaseWebViewController * bvc = [[BaseWebViewController alloc]init];
    bvc.baseUrl = urlArr[k];
    if([self.delegate respondsToSelector:@selector(headClickUrl:)]){
        [self.delegate headClickUrl:urlArr[k]];
    }
   // [self.navigationController pushViewController:bvc animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsModel * model = _dataSource[indexPath.row];
    [cell setData:model];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseWebViewController * webv = [[BaseWebViewController alloc]init];
    NewsModel * mdoel = _dataSource[indexPath.row];
    webv.baseUrl = mdoel.url;
    // webv.hidesBottomBarWhenPushed = YES;
    //[self.navigationController pushViewController:webv animated:YES];
    if([self.delegate respondsToSelector:@selector(tableClickUrl:)]){
        [self.delegate tableClickUrl:mdoel.url];
    }
}
-(void)bannerScrollView:(ScrollHeadView *)bannerScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
