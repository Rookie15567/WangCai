//
//  MyApplyForViewController.m
//  WangCai
//
//  Created by cds on 17/1/7.
//  Copyright © 2017年 cds. All rights reserved.
//

#import "MyApplyForViewController.h"
#import "LoanTableViewCell.h"
#import "LoanMainCellModel.h"
#import "BaseWebViewController.h"
@interface MyApplyForViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
}
@end

@implementation MyApplyForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LoanTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self createDataSource];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(void)createDataSource{
    _dataSource = [NSMutableArray array];
   NSArray *arr= [NSUSERDEF valueForKey:DISK_USER_APPLR];
    NSLog(@"%@",arr);
    for(int i=0;i<arr.count;i++){
        LoanMainCellModel * model = [LoanMainCellModel modelWithDictionary:arr[i]];
        [_dataSource addObject:model];
        [_tableView reloadData];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LoanMainCellModel * model = _dataSource[indexPath.row];
    [cell setDataSource:model];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanMainCellModel * model = _dataSource[indexPath.row];
    BaseWebViewController * bvc = [[BaseWebViewController alloc]init];
    bvc.baseUrl = model.h5;
    [self.navigationController pushViewController:bvc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*K_S_H;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [MobClick beginLogPageView:@"myApply"];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"myApply"];
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
