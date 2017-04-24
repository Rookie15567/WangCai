//
//  LookForLoanViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LookForLoanViewController.h"
#import "LookForLoanTableViewCell.h"
#import "LookForLoanHeadView.h"
#import "LoanDetailViewController.h"
#import "LoanMainCellModel.h"

#define CELLid @"cellid"
#define SECTION_H 40*K_S_H
#define CELL_W 110
#define HEADVIEW_H 120*K_S_H
#define SECTION @"精心推选%@商品"
@interface LookForLoanViewController ()<UITableViewDelegate,UITableViewDataSource,PickClickDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    BOOL change;
}
@property (nonatomic,strong)YYLabel * inSectionLabel;

@end

@implementation LookForLoanViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [MobClick beginLogPageView:@"lookForLoan"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"lookForLoan"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    change = NO;
    if(!_Mnum){
       _Mnum =@"0";
    }
    if(!_RMBnum){
        _RMBnum = @"0";
    }
    _dataSource = [NSMutableArray array];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"找借款";
    [self createUI];
     [Reachability isReachability];
    [self requestHeadDataMnum:_Mnum RMBnum:_RMBnum];//默认
    // Do any additional setup after loading the view.
}
-(void)doBack:(UIButton *)but
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];

}
/**
 请求查询数据
 */
-(void)requestHeadDataMnum:(NSString * )mnum RMBnum:(NSString *)rmbnum{
    _dataSource = [NSMutableArray array];
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"mnum":mnum,@"rmbnum":rmbnum};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:SEARCH_USER_MONEY
                       Block:^(id datt) {
                                         NSLog(@"%@",datt);
                   if([datt[@"code"] isEqualToString:@"0000"]){
                                             
                   for(int  i=0;i<[datt[@"rt"] count];i++){
                      LoanMainCellModel * model = [LoanMainCellModel modelWithDictionary:datt[@"rt"][i]];
                                                 //进行筛选
                         if([_speed isEqualToString:@"1"]){
                             NSString *time = datt[@"rt"][i][@"outtime"];
                               if(![time containsString:@"天"]){
                                                      [_dataSource addObject:model];
                                   NSLog(@"outtime = %@",datt[@"rt"][i][@"outtime"]);
                                }
                        }else if ([_speed isEqualToString:@"2"]){
                                    NSString * money =datt[@"rt"][i][@"maxRmb"];
                                    if([money integerValue] >20000){
                                        [_dataSource addObject:model];
                                        NSLog(@"money = %@",datt[@"rt"][i][@"maxRmb"]);
                                    }
                        }else{
                            
                               [_dataSource addObject:model];
                        }
                       
                }
                       NSLog(@"datesss == %@",_dataSource);
                    if(1){
                        if(![_speed isEqualToString:@"1"] ||![_speed isEqualToString:@"2"]){
                            NSLog(@"%@",_idArray);
                            NSMutableArray * falgArr = [NSMutableArray array];
                            for(int k=0;k<_idArray.count;k++){
                                for(int j=0;j<_dataSource.count;j++){
                                    LoanMainCellModel * model2 = _dataSource[j];
                                    NSLog(@"%@",model2.id);
                                    if([model2.id isEqualToString:_idArray[k]]){
                                        [falgArr addObject:model2];
                                    }
                                }
                            }
                            _dataSource = [NSMutableArray arrayWithArray:falgArr];
                        }
                    }
            [_tableView reloadData];
            }
                }];
}

-(void)createUI{
    [self createTableView];
}
-(LookForLoanHeadView*)createHeadView{
    LookForLoanHeadView * hview = [[LookForLoanHeadView alloc]initWithFrame:CGRectMake(0, 0, S_W, HEADVIEW_H)];
    hview.delegate = self;
    hview.selectRmbNum = _RMBnum;
    hview.selectmnum = _Mnum;
    return hview;
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self createHeadView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LookForLoanTableViewCell class] forCellReuseIdentifier:CELLid];
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView registerClass:[LookForLoanTableViewCell class] forCellReuseIdentifier:CELLid];
    LookForLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LoanMainCellModel * model = _dataSource[indexPath.row];
    [cell setData:model];
    if(indexPath.row<5){
        cell.tagImageView.hidden = NO;
    }else{
        cell.tagImageView.hidden = YES;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_W;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, SECTION_H)];
    _inSectionLabel = [[YYLabel alloc]initWithFrame:view.bounds];
    _inSectionLabel.textAlignment = NSTextAlignmentCenter;
    _inSectionLabel.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
    _inSectionLabel.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
    _inSectionLabel.text = [NSString stringWithFormat:SECTION,[NSString stringWithFormat:@"%ld",(unsigned long)_dataSource.count]];
    [view addSubview:_inSectionLabel];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanDetailViewController * lovc = [[LoanDetailViewController alloc]init];
    LoanMainCellModel * model = _dataSource[indexPath.row];
    lovc.pid = model.id;
    [RequestHelp userClickLogType:userCliclTypeLoan andPid:model.id Block:^(id datt) {
        
    }];
    //lovc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lovc animated:YES];
    //lovc.hidesBottomBarWhenPushed = YES;
}
#pragma mark - pickDelegate
-(void)pickClickAndType:(pickType)type ClickString:(NSString *)string
{
    NSLog(@"%@",string);
    _inSectionLabel.text = [NSString stringWithFormat:SECTION,[NSString stringWithFormat:@"%lu",(unsigned long)_dataSource.count]];
    
    if(type == pickOne){
        NSLog(@"pickone");
        //钱数
        if([string isEqualToString:@"不限"]){
            _RMBnum = @"0";
        }else{
            _RMBnum = string;
        }
       
    }else if(type == pickTwo){
        //月数
        if([string isEqualToString:@"不限"]){
            _Mnum = @"0";
        }else{
            _Mnum = string;
        }
    }
    change = YES;
    [self requestHeadDataMnum:_Mnum RMBnum:_RMBnum];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
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
