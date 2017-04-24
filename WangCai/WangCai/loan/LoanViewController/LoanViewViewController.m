//
//  LoanViewViewController.m
//  WangCai
//
//  Created by cds on 16/12/1.
//  Copyright © 2016年 cds. All rights reserved.
//

#import "LoanViewViewController.h"
#import "LoanViewBaseHeader.h"
#import "LoanTableViewCell.h"
#import "LookForLoanViewController.h"
#import "LoanDetailViewController.h"
#import "LoginViewController.h"
#import "LoanModel.h"
#import "SystemFirstView.h"
#define HEADVIEW_H 500*K_S_H
#define CELLID @"cellid"
@interface LoanViewViewController ()<UITableViewDelegate,UITableViewDataSource,headViewDelegate,LoginIsReach>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    NSMutableArray * _headViewSource;
    NSMutableArray * _idArray;
}
@property (nonatomic,strong) LoanViewBaseHeader * headerView;
@property (nonatomic,strong) SystemFirstView * firstVIew;
@end

@implementation LoanViewViewController

#pragma mark - 登录后是否需要刷新代理
-(void)selfViewDissMiss:(UIView *)view
{
    NSLog(@"dissssss");
    
    [self requestData];
    [self requestHeadData];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"51旺财-借款";
    _dataSource = [NSMutableArray array];
    _headViewSource = [NSMutableArray array];
    _idArray = [NSMutableArray array];
//    [RequestHelp systemIsBlock:^(id datt) {
//        
//    }];
    NSLog(@"CFBundleVersion%@ == ",PHONE_VERSION);
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
          [self initFristPage];
          
          [self registerForKeyboardNotifications];
      }else{
          [weakSelf createUI];
          [weakSelf requestData];
          [weakSelf requestHeadData];
          
      }
  }];
   
    //[self createUI];
    //[self requestData];
    //[self requestHeadData];
    //[self initFristPage];
    //[self registerForKeyboardNotifications];
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}
//键盘将要显示通知
-(void)keyboardWasShown:(NSNotification*)notification{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //self.keyBoardHeight = rect.size.height;
    NSLog(@"ffff  =  %f",_firstVIew.telNumInput.frame.origin.y);
    CGFloat kety = 0;
    if(IPHONE4_OR_4S){
        kety = 282;
    }else{
        kety = rect.origin.y;
    }
    NSLog(@"%f == %f",_firstVIew.telNumInput.frame.origin.y+_firstVIew.telNumInput.frame.size.height-44*K_S_H,rect.origin.y);
    if(_firstVIew.telNumInput.frame.origin.y+_firstVIew.telNumInput.frame.size.height-44*K_S_H < rect.origin.y){
            [UIView animateWithDuration:duration animations:^{
                _firstVIew.frame = CGRectMake(_firstVIew.frame.origin.x,_firstVIew.telNumInput.frame.origin.y - rect.origin.y - _firstVIew.telNumInput.frame.size.height -10 , _firstVIew.frame.size.width, _firstVIew.frame.size.height);
            }];
    }else if (IPHONE4_OR_4S){
        [UIView animateWithDuration:duration animations:^{
            _firstVIew.frame = CGRectMake(_firstVIew.frame.origin.x,-((_firstVIew.telNumInput.frame.origin.y+_firstVIew.telNumInput.frame.size.height-44*K_S_H)-(S_H-rect.origin.y))-54*K_S_H, _firstVIew.frame.size.width, _firstVIew.frame.size.height);
        }];
    }

    
}
-(void)keyboardWillBeHidden:(NSNotification*)notification{
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration animations:^{
        _firstVIew.frame = CGRectMake(0, -44*K_S_H, S_W, S_H+44);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_firstVIew.nameInput.textFile resignFirstResponder];
    [_firstVIew.ageInput.textFile resignFirstResponder];
    [_firstVIew.telNumInput.textFile resignFirstResponder ];
    [_firstVIew.loanInput.textFile resignFirstResponder];
}
- (void)unregNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)initFristPage{
    if(!_firstVIew){
    _firstVIew = [[SystemFirstView alloc]initWithFrame:CGRectMake(0, -44*K_S_H, S_W, S_H+44)];
    [self.view addSubview:_firstVIew];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
     [MobClick beginLogPageView:@"loan"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"loan"];
}
/**
 请求轮播数据
 */
-(void)requestHeadData{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:HOME
                                     Block:^(id datt) {
                                         if([datt[@"code"] isEqualToString:@"0000"]){
                                             for(int  i=0;i<[datt[@"rt"] count];i++){
                                                 LoanModel * model = [LoanModel modelWithDictionary:datt[@"rt"][i]];
                                                 [_headViewSource addObject:model];
                                                
                                             }
                                             [_headerView setData:_headViewSource];//添加数据
                                             
                                         }
                                     }];
}

/**
 请求列表数据
 */
-(void)requestData{
    NSDictionary * dict = @{@"userid":PHONE_USERID,@"token":PHONE_TOKEN,@"version":PHONE_VERSION};
    //数据请求
    [RequestHelp PostRequestWithParameters:dict RequestString:HOMEMEONEYLIST
                                     Block:^(id datt) {
                                         
        if([datt[@"code"] isEqualToString:@"0000"]){
            for(int  i=0;i<[datt[@"rt"] count];i++){
                LoanMainCellModel * model = [LoanMainCellModel modelWithDictionary:datt[@"rt"][i]];
                [_idArray addObject:model.id];
                [_dataSource addObject:model];
            }
            
            [_tableView reloadData];
        }
        if([datt[@"desc"] isEqualToString:@"请重新登录"]){
            [MBProgressHUD showWithText:@"请重新登录" view:nil];
            [Reachability leaveLogin];
            LoginViewController * log = [[LoginViewController alloc]init];
            log.delegate = self;
            [self presentViewController:log animated:YES completion:^{
                NSLog(@"ss");
            }];
            NSLog(@"log.isReash == %@",log.isReash);
        }
    }];
}

/**
 创建UI
 */
-(void)createUI{
    
    _headerView = [[LoanViewBaseHeader alloc]initWithFrame:CGRectMake(0, 0, S_W, HEADVIEW_H)];
    _headerView.delegate = self;
    
   
    [self createTablieView];
}

/**
 创建TableView
 */
-(void)createTablieView{
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_W, S_H-kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LoanTableViewCell class] forCellReuseIdentifier:CELLID];
    [self.view addSubview:_tableView];
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView registerClass:[LoanTableViewCell class] forCellReuseIdentifier:CELLID];
    LoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LoanMainCellModel * model = _dataSource[indexPath.row];
    
    [cell setDataSource:model];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataSource.count>16){
        return 16;
    }else{
      return _dataSource.count;
    }
//    return _dataSource.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"eeeeee";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30*K_S_H;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vieee = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 30*K_S_H)];
    UILabel * label = [[UILabel alloc]init];//WithFrame:CGRectMake(20, 0, S_W-20, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    [vieee addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20*K_S_H, 0, 0));
        make.left.equalTo(vieee.mas_left).with.offset(20*K_S_W);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(vieee.mas_bottom).with.offset(0);
    }];
    vieee.backgroundColor = [UIColor whiteColor];
    
    label.text = @"热门产品";
    label.font = [UIFont fontWithName:ALL_NAV_TITLE_LIGHT size:14];
    label.textColor = [RGBColor colorWithHexString:TEXT_GARYCOLOR];
    return vieee;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 100)];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.85*S_W, 0.85*S_W*0.156)];
    button.backgroundColor = [RGBColor colorWithHexString:ALL_ENV_BLUE_COLOR];
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(MoreOnClick) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:@"查看更多借款产品>" forState:UIControlStateNormal];
    
    [button setFont:[UIFont fontWithName:ALL_NAV_TITLE_REGU size:17]];
    button.center = vv.center;
    [vv addSubview:button];
    return vv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*K_S_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanDetailViewController * lovc = [[LoanDetailViewController alloc]init];
    LoanModel * model = _dataSource[indexPath.row];
    lovc.pid = model.id;
    [RequestHelp userClickLogType:userCliclTypeLoan andPid:model.id Block:^(id datt) {
        
    }];
    lovc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lovc animated:YES];
    lovc.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 更多
-(void)MoreOnClick{
    LookForLoanViewController * lvc = [[LookForLoanViewController alloc]init];
    lvc.hidesBottomBarWhenPushed = YES;
    lvc.idArray = _idArray;
    [self.navigationController pushViewController:lvc animated:YES];
    lvc.hidesBottomBarWhenPushed = NO;
}
#pragma mark - headViewDelegate
-(void)headViewOnClickType:(HeadClickType)type Str:(NSString *)string
{
    BOOL k = [Reachability isReachability];
    NSLog(@"k === %u",k);
    switch (type) {
        case HeadScrollView: //轮播图片
        {
            BaseWebViewController * bvc = [[BaseWebViewController alloc]init];
            LoanModel * model = _headViewSource[[string integerValue]];
            bvc.baseUrl = @"https://api.51jiuji.com/v1/m#/u_loginregist?utm_source=51wangcai&_k=hm9vo8";//[model.h5 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
            [RequestHelp userClickLogType:userCliclTypeBanner andPid:model.id Block:^(id datt) {
                
            }];
            [self.navigationController pushViewController:bvc animated:YES];
            bvc.hidesBottomBarWhenPushed = NO;
            break;
            
        }
        case HeadADView: //滚动广告
        {
            break;
        }
        case HeadMenuView:  // 三个按钮
        {
            if([string isEqualToString:@"10"]){
                //极速
                LookForLoanViewController * lvc = [[LookForLoanViewController alloc]init];
                lvc.speed = @"1";
                lvc.idArray = _idArray;
                [self.navigationController pushViewController:lvc animated:YES];
                
            }else if ([string isEqualToString:@"11"]){
                LookForLoanViewController * lvc = [[LookForLoanViewController alloc]init];
                lvc.speed = @"2";
                lvc.idArray = _idArray;
                [self.navigationController pushViewController:lvc animated:YES];
            }else if ([string isEqualToString:@"12"]){
                NSLog(@"%@",self.tabBarController.childViewControllers);
                self.tabBarController.selectedIndex = 1;
            }
            break;
        }
        case HeadLoanView: //查询
        {
            [RequestHelp userClickLogType:userCliclTypeSearch andPid:@"0" Block:^(id datt) {
                
            }];
            LookForLoanViewController * lookVc = [[LookForLoanViewController alloc]init];
            
            if([string isEqualToString:@"20"]){
                lookVc.Mnum = @"3";
                lookVc.RMBnum = @"3000";
            }else if ([string isEqualToString:@"21"]){
                lookVc.Mnum = @"5";
                lookVc.RMBnum = @"5000";
            }else if ([string isEqualToString:@"22"]){
                lookVc.Mnum = @"3";
                lookVc.RMBnum = @"8000";
            }else if ([string isEqualToString:@"23"]){
                lookVc.Mnum = @"12";
                lookVc.RMBnum = @"20000";
            }else{
                lookVc.Mnum = @"0";
                lookVc.RMBnum = string;
            }
            lookVc.idArray = _idArray;
            [self.navigationController pushViewController:lookVc animated:YES];
            break;
        }
        default:
            break;
    }
//    LoginViewController * lvc = [[LoginViewController alloc]init];
//    
//    [self.navigationController pushViewController:lvc
//                                         animated:YES];
    NSLog(@"%@",string);
}
-(void)dealloc
{
    [self unregNotification ];
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
