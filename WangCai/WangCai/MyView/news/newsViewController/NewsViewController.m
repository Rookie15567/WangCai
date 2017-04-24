//
//  NewsViewController.m
//  WangCai
//
//  Created by cds on 16/12/6.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "BaseWebViewController.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    
    NSMutableArray * _dataSource;
}
@end

@implementation NewsViewController


-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"myNews"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createDataSource];
    [self createTableView];
    self.view.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
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
-(void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kNavigationBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.delegate =self;
    _tableView.dataSource = self;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseWebViewController * webv = [[BaseWebViewController alloc]init];
    NewsModel * mdoel = _dataSource[indexPath.row];
    webv.baseUrl = mdoel.url;
   // webv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webv animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
     [MobClick beginLogPageView:@"myNews"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
