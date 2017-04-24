//
//  CardListViewController.m
//  WangCai
//
//  Created by cds on 16/12/5.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "CardListViewController.h"
#import "CardListTableViewCell.h"
#import "CardListModel.h"
#import "BaseWebViewController.h"
@interface CardListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    
}
@end
#define CELL_H 80
@implementation CardListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"creditList"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"creditList"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    [self createTableView];
    [self requestData];
}
-(void)requestData{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"bankid":_bankId};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:HOMECARDLIST Block:^(id datt) {
        if([datt[@"code"] isEqualToString:@"0000"]){
            for(int  i=0;i<[datt[@"rt"] count];i++){
                CardListModel * model = [CardListModel modelWithDictionary:datt[@"rt"][i]];
                [_dataSource addObject:model];
            }
            [_tableView reloadData];
        }
        NSLog(@"%@",datt);
    }];
}
-(void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CardListTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CardListModel * model = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell changData:model];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_H;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 60)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardListModel * model = _dataSource[indexPath.row];
    BaseWebViewController * bvc = [[BaseWebViewController alloc]init];
    bvc.baseUrl = model.h5;
    [self.navigationController pushViewController:bvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
