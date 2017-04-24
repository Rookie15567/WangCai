//
//  creditcardViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "creditcardViewController.h"
#import "cradHeadView.h"
#import "cardTableViewCell.h"
#import "CardListViewController.h"
#import "CredCardModel.h"
#import "SystemTwoView.h"
#define HEAD_H 30
@interface creditcardViewController ()<headDelegate,UITableViewDelegate,UITableViewDataSource,systemClickdelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    NSMutableArray * _headSource;
    cradHeadView * hview;
}
@end

@implementation creditcardViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [MobClick beginLogPageView:@"credit"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"credit"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    NSDictionary * dict = @{@"userid":@"0",@"token":@"",@"version":PHONE_VERSION};
    [RequestHelp PostRequestWithParameters:dict RequestString:SYSINFO Block:^(id datt) {
        NSLog(@"%@",datt);
        
        NSString * str = datt[@"rt"][@"flag"];
        NSString * version = datt[@"rt"][@"appversion"];
        NSString * version1 = PHONE_VERSION;
        NSLog(@"version=%@-%@",version1,version);
        //      if([version1 integerValue] == [version integerValue]){
        //          NSLog(@"啊结果发送吧");
        //      }
        if([str integerValue] == 1 || [version1 integerValue] == [version integerValue] ){
            //皮
//            [self initFristPage];
//
            weakSelf.view.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
            
            SystemTwoView * sys = [[SystemTwoView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kNavigationBarHeight)];
            sys.delegate = self;
            weakSelf.navigationItem.title = @"51旺财";
            [weakSelf.view addSubview:sys];
//            [self registerForKeyboardNotifications];
        }else{
//            [weakSelf createUI];
//            [weakSelf requestData];
//            [weakSelf requestHeadData];
            [weakSelf createaUI];
            weakSelf.view.backgroundColor = [UIColor whiteColor];
            _dataSource = [NSMutableArray array];
            _headSource = [NSMutableArray array];
            weakSelf.navigationItem.title = @"信用卡";
            [weakSelf requestData];
            [weakSelf requestHeadData];
        }
    }];
//
//    [self createaUI];
//    _dataSource = [NSMutableArray array];
//    _headSource = [NSMutableArray array];
//    self.navigationItem.title = @"信用卡";
//    [self requestData];
//    [self requestHeadData];
        // Do any additional setup after loading the view.
}
-(void)requestHeadData{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"bankid":@"2"};
    [RequestHelp PostRequestWithParameters:dict RequestString:HOMECARDLIST Block:^(id datt) {
        if([datt[@"code"] isEqualToString:@"0000"]){
            NSLog(@"datttt =====%@",datt);
            for(int  i=0;i<[datt[@"rt"] count];i++){
                
                CredCardModel  * model = [CredCardModel modelWithDictionary:datt[@"rt"][i]];
                
                    [_headSource addObject:model];
               
                
            }
            [_tableView reloadData];
            [hview setData:_headSource];
        }
        NSLog(@"%@",datt);
    }];

}
-(void)requestData{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:HOMEBANKLIST Block:^(id datt) {
        if([datt[@"code"] isEqualToString:@"0000"]){
            for(int  i=0;i<[datt[@"rt"] count];i++){
                
               CredCardModel  * model = [CredCardModel modelWithDictionary:datt[@"rt"][i]];
                
                [_dataSource addObject:model];
                
            }
            [_tableView reloadData];
            
        }
        NSLog(@"%@",datt);
    }];

}
-(void)createaUI{
    [self createTableView];
}
-(cradHeadView*)createHeadView{
    hview = [[cradHeadView alloc]initWithFrame:CGRectMake(0, 0, S_W, 360-140+BANNER_H)];
    hview.delegate = self;
    //hview.backgroundColor = [UIColor blueColor];
   // [hview setData:_headSource];
    return hview;
}
-(void)createTableView{
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kNavigationBarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [RGBColor colorWithHexString:LINE_EEEEECOLOR];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self createHeadView];
    [_tableView registerClass:[cardTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CredCardModel * model = _dataSource[indexPath.row];
    [cell changData:model];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;//17 38 16
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * viw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, HEAD_H)];
    viw.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 30, 12)];
    label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:12];
    label.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
    label.text = @"推荐";
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, 12)];
    label.frame = CGRectMake(20, 0, size.width, 12);
    label.center = CGPointMake(label.center.x, viw.center.y);
    [viw addSubview:label];
    return viw;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEAD_H;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 80)];
    view.backgroundColor = _tableView.backgroundColor;
    //_foot.backgroundColor = [RGBColor colorWithHexString:TEXT_9999COLOR];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CredCardModel * model = _dataSource[indexPath.row];
//    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"pid":model.id};
//    //数据请求
//    [RequestHelp PostRequestWithParameters:dict RequestString:BANK_ID Block:^(id datt) {
//        NSLog(@"datt == %@",datt);
//        if([datt[@"code"] isEqualToString:@"0000"]){
//            for(int i=0;i<[datt[@"rt"] count];i++){
//                //CredCardModel * model = [CredCardModel modelWithDictionary:datt[@"rt"][i]];
// //               [_dataSource addObject:model];
//            }
//            [_tableView reloadData];
//        }
//    }];
    NSString * backid = model.id;
    if(!backid  || backid.length == 0 ){
        backid = @"0";
    }
    [RequestHelp userClickLogType:userCliclTypeBank andPid:backid Block:^(id datt) {
        
    }];
    if([model.listflag isEqualToString:@"1"]){
        NSLog(@"%@",model.id);
        CardListViewController * clvc = [[CardListViewController alloc]init];
        clvc.bankId = model.id;
        clvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:clvc animated:YES];
        clvc.hidesBottomBarWhenPushed = NO;
    }else{
        BaseWebViewController * bwevc = [[BaseWebViewController alloc]init];
        bwevc.baseUrl = model.h5;
        [self.navigationController pushViewController:bwevc animated:YES];
        
       // NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION,@"pid":model.id};
        //数据请求
//        [RequestHelp PostRequestWithParameters:dict RequestString:BANK_ID Block:^(id datt) {
//            if([datt[@"code"] isEqualToString:@"0000"]){
//                for(int  i=0;i<[datt[@"rt"] count];i++){
//                    CredCardModel * model = [CredCardModel modelWithDictionary:datt[@"rt"][i]];
//                    [_dataSource addObject:model];
//                }
//                [_tableView reloadData];
//            }
//            NSLog(@"%@",datt);
//        }];

    }
    
    
    if(indexPath.row == 3){
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - headDelagate
-(void)headViewSelectType:(headSelectType)type
{
    if(_headSource.count>1){
    if(type == headTrendOne){
        CredCardModel * model = _headSource[0];
        BaseWebViewController * wbvc = [[BaseWebViewController alloc]init];
        wbvc.baseUrl = model.h5;
        [self.navigationController pushViewController:wbvc animated:YES];
    }else if (type == headTrendTwo){
        CredCardModel * model = _headSource[1];
        BaseWebViewController * wbvc = [[BaseWebViewController alloc]init];
        wbvc.baseUrl = model.h5;
        [self.navigationController pushViewController:wbvc animated:YES];
    }
    }
}

-(void)tableClickUrl:(NSString *)url
{
    BaseWebViewController * wbvc = [[BaseWebViewController alloc]init];
    wbvc.baseUrl = url;
    [self.navigationController pushViewController:wbvc animated:YES];
}
-(void)headClickUrl:(NSString *)url
{
    BaseWebViewController * wbvc = [[BaseWebViewController alloc]init];
    wbvc.baseUrl = url;
    [self.navigationController pushViewController:wbvc animated:YES];
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
