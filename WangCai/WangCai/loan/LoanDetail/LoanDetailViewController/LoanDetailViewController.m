//
//  LoanDetailViewController.m
//  WangCai
//
//  Created by cds on 16/12/2.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "LoanDetailHeadView.h"
#import "LoanDetailTableViewCell.h"
#import "ToolBarView.h"
#import "LoginViewController.h"
#import "BaseWebViewController.h"
#import <MJExtension.h>
@interface LoanDetailViewController ()<UITableViewDelegate,UITableViewDataSource,headDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    NSArray * _cellArray;
    UIView * _myToolBar;
    LoanDetailModel * detailModel;
    LoanDetailHeadView * headview;
}
@property (nonatomic,strong)UIView * backView;
@end
#define CELLID @"cell"
#define CELL_H 90
#define HEADVIEW_H 280*K_S_H
@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"借款详情";
    self.view.backgroundColor = [RGBColor colorWithHexString:LINE_COLOR];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self requestDetailData];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)requestDetailData{
     NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"pid":_pid};
    [RequestHelp PostRequestWithParameters:dict RequestString:MONEY_ID Block:^(id datt) {
        NSLog(@"%@",datt);
        if(datt[@"rt"] ){
        detailModel = [LoanDetailModel modelWithDictionary:datt[@"rt"]];
        [headview setData:detailModel];
        
        _cellArray = @[@[@"申请资格",detailModel.info1],@[@"所需材料",detailModel.info2]];
           
        [_tableView reloadData];
        }
    }];
}
-(void)doBack:(UIButton *)but
{
    self.tabBarController.tabBar.hidden = NO;

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createUI{
    _backView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 0)];
    _backView.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
    [self.view addSubview:_backView];
    [self createTableView];
    [self createToolBar];
   // [self.view addSubview:_backView];
}
#define label_FONT 18
-(void)createToolBar
{
    ToolBarView * tool = [[ToolBarView alloc]initWithFrame:CGRectMake(0, S_H-50-64, S_W, 50)];
    __weak typeof(self) weakSelf = self;
    tool.ToolBlock = ^(NSInteger num){
        [weakSelf detailVcPushLoginOrH5];
    };
    [self.view addSubview:tool];
}
-(void)tapToolBar{
    
}
-(LoanDetailHeadView*)createHeadView{
    headview = [[LoanDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, S_W, HEADVIEW_H)];
    headview.delegate = self;
    [headview setData:detailModel];
    
    return headview;
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self createHeadView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LoanDetailTableViewCell class] forCellReuseIdentifier:CELLID];
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView registerClass:[LoanDetailTableViewCell class] forCellReuseIdentifier:CELLID];
    LoanDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(_cellArray.count<1){
        _cellArray = @[@[@"申请资格",@""],@[@"所需材料",@""]];
    }
    [cell changData:_cellArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_cellArray[indexPath.row]);
    return [self autoCalculateWidthOrHeight:MAXFLOAT width:S_W-40*K_S_W fontsize:BIG_LABLE_FONT content:_cellArray[indexPath.row][1]] + 72*K_S_H;//82*K_S_H;
}
#pragma mark -- 计算宽窄的函数
-(float)autoCalculateWidthOrHeight:(float)height
                             width:(float)width
                          fontsize:(float)fontsize
                           content:(NSString*)content
{
    //计算出rect
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
    
    //判断计算的是宽还是高
    //if (height == MAXFLOAT) {
        return rect.size.height;
    //}
   // else
     //   return rect.size.width;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellArray[section] count];
}
#pragma mark - scrollerView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if(y<0){
    _backView.frame = CGRectMake(0, 0, S_W, -y);
    }
}
#pragma mark - 登录或者h5
-(void)detailVcPushLoginOrH5{
    if([Reachability isNeedLogin]){
        LoginViewController * lvc= [[LoginViewController alloc]init];
        [self presentViewController:lvc animated:YES completion:^{
            
        }];
    }else{
        
        BaseWebViewController * bVc = [[BaseWebViewController alloc]init];
//        bVc.baseUrl =  [detailModel.h5 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        bVc.baseUrl = [detailModel.h5 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        bVc.buffDict = [detailModel mj_keyValues];
        NSLog(@"%@",bVc.buffDict);
        bVc.isDetail = YES;
        bVc.mnum = headview.bottomView.twoString;
        bVc.rmbnum =headview.bottomView.oneString;
        [self.navigationController pushViewController:bVc animated:YES];
    }
}
-(void)pickClick:(pickType)type str:(NSString *)string
{
    
}
-(NSString*)calculateMoneyAllMoney:(NSString*)money month:(NSString*)monthstr rate:(NSString*)rate
{
    NSInteger abuff = [money integerValue]/[monthstr integerValue];
    NSInteger buff = abuff+ [money integerValue]* [rate integerValue]/100;
    return [NSString stringWithFormat:@"%ld",buff];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [MobClick beginLogPageView:@"loanDetail"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"loanDetail"];
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
